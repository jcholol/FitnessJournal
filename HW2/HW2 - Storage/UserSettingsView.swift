//
//  UserSettingsView.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftUI

struct UserSettingsView: View {
    @AppStorage("username") var username = ""

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .onChange(of: username) {
                    // Store the new username in the app storage
                    UserDefaults.standard.set(username, forKey: "username")
                }
            Text("Current Username: \(username)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

/*

 */

#Preview {
    UserSettingsView()
}
