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

    @State private var showCreate = false
    @State private var entryEdit: MediaItem?
    @Query private var items: [MediaItem]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            if item.isCompleted {
                                CircleImage(image: Image("hello"))
                            }

                            Text(item.title)
                                .font(.largeTitle)
                                .bold()

                            Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                .font(.callout)
                        }

                        Spacer()

                        Button {
                            withAnimation {
                                item.isCompleted.toggle()
                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .symbolVariant(.circle.fill)
                                .foregroundStyle(item.isCompleted ? .green : .gray)
                        }
                        .buttonStyle(.plain)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                context.delete(item)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .symbolVariant(.fill)
                        }

                        Button {
                            entryEdit = item
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.orange)
                    }
                }
            }
            .navigationTitle("Media/User Settings")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showCreate.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $showCreate, content: {
                NavigationStack {
                    JournalEntry()
                }
                .presentationDetents([.medium])
            })
            .sheet(item: $entryEdit) {
                entryEdit = nil
            } content: { item in
                UpdateJournalEntry(item: item)
            }
        }
    }
}

#Preview {
    ContentView()
}

//        HStack {
//            TabView {
//                UserSettingsView()
//                    .tabItem {
//                        Text("UserSettings")
//                    }
//                MediaItemView()
//                    .tabItem {
//                        Text("MediaItem")
//                    }
//            }
//        }
//    }
//        HStack {
//            TabView {
//                Dashboard()
//                    .tabItem {
//                        Image(systemName: "square.grid.3x3.middle.fill")
//                        Text("Dashboard")
//                    }
//                Log()
//                    .tabItem {
//                        Image(systemName: "fork.knife.circle")
//                        Text("Food Log")
//                    }
//                Plans()
//                    .tabItem {
//                        Image(systemName: "pencil.and.list.clipboard")
//                        Text("Diet Plans")
//                    }
//                More()
//                    .tabItem {
//                        Image(systemName: "ellipsis")
//                        Text("More")
//                    }
//            }
//        }
//        .padding()
//    }
