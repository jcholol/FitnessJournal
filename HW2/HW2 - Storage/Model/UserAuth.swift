import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class UserAuth: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        Auth.auth().addStateDidChangeListener {_, user in
            self.isLoggedIn = user != nil
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            self.isLoggedIn = true
            completion(nil)
        }
    }
    
    func signUp(email: String, password: String, username: String, completion: @escaping (String?) -> Void) {
        print("Creating user with email: \(email), password: \(password)")
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Firebase Auth error: \(error.localizedDescription)")
                completion(error.localizedDescription)
                return
            }
            
            guard let user = authResult?.user else {
                print("Failed to retrieve user after sign-up.")
                completion("Failed to retrieve user.")
                return
            }
            
            print("User signed up successfully. UID: \(user.uid)")

            // Save additional user data to Firestore
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData([
                "username": username,
                "email": email,
                "calorieGoal": 2000  // Default calorie goal
            ]) { error in
                if let error = error {
                    print("Firestore error: \(error.localizedDescription)")
                    completion(error.localizedDescription)
                    return
                }
                print("User successfully signed up and data saved to Firestore.")
                self.isLoggedIn = true
                completion(nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
