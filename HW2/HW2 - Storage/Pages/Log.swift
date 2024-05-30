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
    
    @Binding var selectedDate: Date
    @State private var showingJournal = false
    @State private var editLog: FoodItem?
    
    @Query var foods: [FoodItem]
    
    var filterFoodItem: [FoodItem] {
        return foods.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }
    
    var body: some View {
        List {
            ForEach(filterFoodItem) { food in
                FoodRow(food: food)
                    .onTapGesture {
                        editLog = food
                    }
            }
            .onDelete { foodIndex in
                for index in foodIndex {
                    context.delete(filterFoodItem[index])
                }
            }
        }
        .sheet(isPresented: $showingJournal) { JournalEntry(selectedDate: $selectedDate) }
        .sheet(item: $editLog) { food in
            UpdateJournalEntry(food: food)
        }
        .toolbar {
            if !filterFoodItem.isEmpty {
                Button("Add Food", systemImage: "plus") {
                    showingJournal = true
                }
            }
        }
        .overlay {
            if filterFoodItem.isEmpty {
                ContentUnavailableView(label: {
                    Label("No food logged", systemImage: "rectangle.and.pencil.and.ellipsis")
                }, description: {
                    Text("Begin journaling your food intake")
                }, actions: {
                    Button("Add Food") {
                        showingJournal = true
                    }
                })
            }
        }
    }
}
