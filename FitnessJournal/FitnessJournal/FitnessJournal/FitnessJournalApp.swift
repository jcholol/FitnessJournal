//
//  FitnessJournalApp.swift
//  FitnessJournal
//
//  Created by Yunho Cho on 6/2/24.
//

import SwiftUI
import SwiftData

@main
struct FitnessJournalApp: App {
    @StateObject var manager = HealthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
        .modelContainer(for: [FoodItem.self, Exercise.self, UserInfo.self])
    }
}
