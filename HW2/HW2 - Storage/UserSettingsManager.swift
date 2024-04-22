//
//  UserSettingsManager.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import Foundation

class UserSettingsManager: ObservableObject {
    @Published var username: String = ""

    static let shared = UserSettingsManager()
    private let userDefaults = UserDefaults.standard

    func storeUserSettings(_ userSettings: UserSettings) {
        userDefaults.set(userSettings.username, forKey: "username")
    }

    func loadUserSettings() -> UserSettings? {
        guard let username = userDefaults.string(forKey: "username") else { return nil
        }
        return UserSettings(username: username)
    }
}
