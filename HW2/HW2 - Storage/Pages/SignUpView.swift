//
//  SignUpView.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 5/25/24.
//
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @EnvironmentObject var userAuth: UserAuth
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .padding()
            
            TextField("Username", text: $username)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
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
                signUp()
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.top)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func signUp() {
        print("Attempting to sign up with email: \(email), password: \(password), username: \(username)")

        userAuth.signUp(email: email, password: password, username: username) { error in
            if let error = error {
                print("Error during sign-up: \(error)")
                alertMessage = error
                showingAlert = true
                return
            }
            handleSuccessfulSignUp()
        }
    }
    
    func handleSuccessfulSignUp() {
        // Dismiss the signup view
        presentationMode.wrappedValue.dismiss()
    }
}
