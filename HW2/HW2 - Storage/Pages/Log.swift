//
//  Log.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftData
import SwiftUI

struct Log: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @Query var foods: [FoodItem]

    @State private var showingJournal = false
    @State private var editLog: FoodItem?

    var body: some View {
        NavigationStack {
            List {
                ForEach(foods) { food in
                    FoodRow(food: food)
                        .onTapGesture {
                            editLog = food
                        }
                }
                .onDelete { foodIndex in
                    for index in foodIndex {
                        context.delete(foods[index])
                    }
                }
            }
            .navigationTitle("Food Journal")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingJournal) { JournalEntry() }
            .sheet(item: $editLog) { food in
                UpdateJournalEntry(food: food)
            }
            .toolbar {
                if !foods.isEmpty {
                    Button("Add Food", systemImage: "plus") {
                        showingJournal = true
                    }
                }
            }
            .overlay {
                if foods.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No food logged", systemImage: "rectangle.and.pencil.and.ellipsis")
                    }, description: {
                        Text("Begin journaling your food intake")
                    }, actions: {
                        Button("Add Food") { showingJournal = true }
                    })
                    .offset(y: -50)
                }
            }
        }
    }
}

#Preview {
    Log()
}
