//
//  JournalEntry.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftUI

struct JournalEntry: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @Binding var selectedDate: Date

    @State private var name: String = ""
    @State private var calories: Double = 0
    @State private var entryDate: Date = .init()
    
    
    private let calorieFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name of Food", text: $name)
                TextField("Amount of calories in kCal", value: $calories, formatter: calorieFormatter)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add Food")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let food = FoodItem(name: name, calories: calories, date: selectedDate)
                        context.insert(food)
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
