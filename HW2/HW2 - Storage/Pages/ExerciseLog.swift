//
//  ExerciseLog.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
// Workaround for date selection https://stackoverflow.com/questions/76444745/swiftdata-predicate-do-not-work-with-date

import SwiftData
import SwiftUI

struct ExerciseLog: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @Binding var selectedDate: Date

    @State private var showingJournal = false
    @State private var editLog: Exercise?
    @Query private var exercises: [Exercise]

    var filterExercise: [Exercise] {
        return exercises.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filterExercise) { exercise in
                    ExerciseRow(exercise: exercise)
                        .onTapGesture {
                            editLog = exercise
                        }
                }
                .onDelete { exerciseIndex in
                    for index in exerciseIndex {
                        context.delete(filterExercise[index])
                    }
                }
            }
            .navigationTitle("Exercise Journal")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingJournal) {
                ExerciseJournal(selectedDate: $selectedDate)
            }
            .sheet(item: $editLog) { exercise in
                UpdateExerciseJournal(exercise: exercise)
            }
            .toolbar {
                if !filterExercise.isEmpty {
                    Button("Add Activity", systemImage: "plus") {
                        showingJournal = true
                    }
                }
            }
            .overlay {
                if filterExercise.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No activity logged", systemImage: "figure.flexibility")
                    }, description: {
                        Text("Begin journaling your exercises!")
                    }, actions: {
                        Button("Add Activity") {
                            showingJournal = true
                        }
                    })
                }
            }
        }
    }
}
