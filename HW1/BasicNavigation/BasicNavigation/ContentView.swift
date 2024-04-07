//
//  ContentView.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresenting: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Toolbar()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresenting = true
                    }) {
                        Label("Profile", systemImage: "person.crop.circle.fill")
                    }
                    .frame(width: 500, height: 500)
                }
            }
            .sheet(isPresented: $isPresenting) {
                NavigationStack {
                    Text("Profiles Page")
                        .toolbar {
                            ToolbarItem {
                                Button(action: {
                                    isPresenting = false
                                }) {
                                    Text("Done")
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
