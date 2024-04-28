//
//  ContentView.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context

    var body: some View {
        HStack {
            TabView {
                Dashboard()
                    .tabItem {
                        Image(systemName: "square.grid.3x3.middle.fill")
                        Text("Dashboard")
                    }
                Log()
                    .tabItem {
                        Image(systemName: "fork.knife.circle")
                        Text("Food")
                    }
                ExerciseLog()
                    .tabItem {
                        Image(systemName: "figure.strengthtraining.traditional")
                        Text("Exercise")
                    }
                Plans()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Diet Plans")
                    }
                More()
                    .tabItem {
                        Image(systemName: "ellipsis")
                        Text("More")
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
