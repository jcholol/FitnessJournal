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
//    let modelContainer: ModelContainer
//
//    init() {
//        do {
//            modelContainer = try ModelContainer(for: FoodItem.self, Exercise.self, UserInfo.self)
//        } catch {
//            fatalError("Could not initialize ModelContainer")
//        }
//    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FoodItem.self, Exercise.self, UserInfo.self])
//        .modelContainer(modelContainer)
    }
}
