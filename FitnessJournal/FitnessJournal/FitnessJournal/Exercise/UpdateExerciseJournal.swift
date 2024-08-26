//
//  UpdateExerciseJournal.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import SwiftUI

struct UpdateExerciseJournal: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var exercise: Exercise

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name of Activity", text: $exercise.name)
                TextField("Amount of calories", value: $exercise.duration, format: .number)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Update Activity")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Update") {
                        dismiss()
                    }
                }
            }
        }
    }
}
