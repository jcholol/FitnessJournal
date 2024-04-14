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
                        // need to fix this to be a tool bar at the top
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .offset(y: -10)
                    }
                }
            }
            .sheet(isPresented: $isPresenting) {
                NavigationStack {
                    Profiles()
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
        .foregroundColor(.black)
    }
}

#Preview {
    ContentView()
}
