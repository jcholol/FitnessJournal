import SwiftData
import SwiftUI

@main
struct HW2___StorageApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FoodItem.self, Exercise.self, UserInfo.self, UserGoals.self])
    }
}
