import SwiftData
import SwiftUI
import FirebaseCore

@main
struct HW2___StorageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var userAuth = UserAuth()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userAuth)
        }
        .modelContainer(for: [FoodItem.self, Exercise.self, UserInfo.self, UserGoals.self])
        //        .modelContainer(modelContainer)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
