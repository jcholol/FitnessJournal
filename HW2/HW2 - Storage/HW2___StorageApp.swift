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
    // Using container outside of swiftui hierachy
//    let container: ModelContainer = {
//        let schema = Schema([FoodItem.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FoodItem.self, Exercise.self])
//        .modelContainer(container)
    }
}
