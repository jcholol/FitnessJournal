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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: MediaItem.self)
        }
    }
}
