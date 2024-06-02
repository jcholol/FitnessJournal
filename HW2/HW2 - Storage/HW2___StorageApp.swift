//
//  HelloWorldApp.swift
//  HelloWorld
//
//  Created by Yunho Cho on 4/4/24.
//

import SwiftData
import SwiftUI

@main
struct HW2___StorageApp: App {
    @StateObject var manager = HealthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
        .modelContainer(for: [FoodItem.self, Exercise.self, UserInfo.self, UserGoals.self])
//        .modelContainer(modelContainer)
    }
}
