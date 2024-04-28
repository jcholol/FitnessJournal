//
//  ExerciseLog.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import SwiftData
import SwiftUI

struct ExerciseLog: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @Query var exercises: [Exercise]

    @State private var showingJournal = false
    @State private var editLog: Exercise?

    var body: some View {
        NavigationStack {
            List {
                ForEach(exercises) { exercise in
                    ExerciseRow(exercise: exercise)
                        .onTapGesture {
                            editLog = exercise
                        }
                }
                .onDelete { exerciseIndex in
                    for index in exerciseIndex {
                        context.delete(exercises[index])
                    }
                }
            }
            .navigationTitle("Exercise Journal")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingJournal) { ExerciseJournal() }
            .sheet(item: $editLog) { exercise in
                UpdateExerciseJournal(exercise: exercise)
            }
            .toolbar {
                if !exercises.isEmpty {
                    Button("Add Activity", systemImage: "plus") {
                        showingJournal = true
                    }
                }
            }
            .overlay {
                if exercises.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No activity logged", systemImage: "figure.flexibility")
                    }, description: {
                        Text("Begin journaling your exercises!")
                    }, actions: {
                        Button("Add Activity") { showingJournal = true }
                    })
                    .offset(y: -50)
                }
            }
        }
    }
}

#Preview {
    ExerciseLog()
}
