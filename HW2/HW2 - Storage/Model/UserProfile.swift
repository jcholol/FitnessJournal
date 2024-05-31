import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Foundation

class UserProfile: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var calorieGoal: Double = 2000
    //@Published var workouts: [Workout] = []

    private var db = Firestore.firestore()
    
    init() {
        fetchUserProfile()
    }

    func fetchUserProfile() {
        guard let user = Auth.auth().currentUser else { return }
        
        self.email = user.email ?? "No Email"
        
        let userRef = db.collection("users").document(user.uid)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.name = data?["username"] as? String ?? "No Name"
                self.calorieGoal = data?["calorieGoal"] as? Double ?? 2000
                //self.fetchUserWorkouts(userId: user.uid)
            } else {
                print("Document does not exist")
            }
        }
    }
}
