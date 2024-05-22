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
    @State private var isCreatingExercise: Bool = false

    @State private var showingJournal = false
    @State private var editLog: Exercise?
    @Query private var exercises: [Exercise]

    var filterExercise: [Exercise] {
        return exercises.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Quick Start")
                    .font(.headline)
                    .padding(.top, 20)

                Button(action: {
                    isCreatingExercise = true
                }) {
                    Text("Start Empty Workout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)

            Text("Routines")
                .font(.headline)
                .padding(.top, 20)

            HStack {
                Button(action: {
                    // Action for creating a new routine
                }) {
                    HStack {
                        Image(systemName: "plus.square")
                        Text("New Routine")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                }

                Button(action: {
                    // Action for exploring routines
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Explore")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)

            Spacer()

            List {
                Section(header: Text("My Routines (3)")) {
                    // List of routines
                    // Store routine into context and query instead of this
                    Text("Routine 1")
                    Text("Routine 2")
                    Text("Routine 3")
                }
            }
        }
        .navigationBarTitle("Workout")
        .sheet(isPresented: $isCreatingExercise) {
            NavigationStack {
                ExerciseJournal(selectedDate: $selectedDate)
            }
        }
    }
}
