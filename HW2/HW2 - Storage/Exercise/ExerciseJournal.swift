//
//  ExerciseJournal.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import SwiftUI

struct ExerciseJournal: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context

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
                TextField("Name of Activity", text: $name)
                TextField("FIX THIS (Amount of calories in kCal)", value: $calories, formatter: calorieFormatter)
                    .keyboardType(.decimalPad)
                DatePicker("Date", selection: $entryDate, displayedComponents: .date)
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let exercise = FoodItem(name: name, calories: calories, date: entryDate)
                        context.insert(exercise)
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

#Preview {
    ExerciseJournal()
}
