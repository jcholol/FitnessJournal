//
//  Profiles.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Profiles: View {
    @State var isDarkMode: Bool = false
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Image(systemName: "person.crop.circle").resizable()
                        .frame(width: 50, height: 50).foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text("User").font(.title2)
                        Text("User Email")
                    }
                }
                Section {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4).fill(.blue)
                                .frame(width: 28, height: 28)
                            Image(systemName: "sun.max.fill").foregroundColor(.white)
                        }
//                        Toggle("App Appearance", systemImage: "moon.fill", isOn: $isDarkMode)
                    }
                }
            }.navigationTitle("Account Settings")
        }
    }
}

#Preview {
    Profiles()
}
