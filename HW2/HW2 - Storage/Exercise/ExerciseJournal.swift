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

    @Binding var selectedDate: Date
    @State private var name: String = ""
    @State private var duration: Int = 0
//    @State private var calories: Double = 0
    @State private var entryDate: Date = .init()

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }()

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name of Activity", text: $name)
                TextField("Duration", value: $duration, formatter: formatter)
                    .keyboardType(.numberPad)
//                TextField("Calories", value: $calories, formatter: formatter)
//                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let exercise = Exercise(name: name, duration: duration, date: selectedDate)
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
