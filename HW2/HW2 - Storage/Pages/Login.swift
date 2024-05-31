import SwiftUI
import UIKit
import FirebaseAuth

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingSignUp = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                Button(action: {
                    showingSignUp = true
                }) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                        .padding()
                }
                .sheet(isPresented: $showingSignUp) {
                    SignUpView()
                        .environmentObject(userAuth)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func login() {
        userAuth.signIn(email: email, password: password) { error in
            if let error = error {
                alertMessage = error
                showingAlert = true
            }
        }
    }
}
