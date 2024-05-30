//
//  Profiles.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Profiles: View {
    @Binding var isDarkMode: Bool
    @StateObject private var viewModel = UserProfile()
    @EnvironmentObject var userAuth: UserAuth

    var body: some View {
        Form {
            ProfileHeader(email: viewModel.email, name: viewModel.name)

            Section(header: Text("App Appearance")) {
                AppAppearanceToggle(isDarkMode: $isDarkMode)
            }

            Section(header: Text("Fitness Information")) {
                GoalsNavigationLink()
            }
            
            Section {
                Button(action: {
                    userAuth.signOut()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Account Settings")
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ProfileHeader: View {
    var email: String
    var name: String

    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text(name).font(.title2)
                Text(email)
            }
        }
    }
}

struct AppAppearanceToggle: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        HStack {
            Settings(iconColor: .blue, iconName: "sun.max.fill")
            Toggle("App Appearance", isOn: $isDarkMode)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
    }
}

struct GoalsNavigationLink: View {
    var body: some View {
        NavigationLink(destination: Goals()) {
            Settings(iconColor: .red, iconName: "target")
            Text("Goals")
        }
    }
}

struct Settings: View {
    let iconColor: Color
    let iconName: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4).fill(iconColor)
                .frame(width: 28, height: 28)
            Image(systemName: iconName).foregroundColor(.white)
        }
    }
}
