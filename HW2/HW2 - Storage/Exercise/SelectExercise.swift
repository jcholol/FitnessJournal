//
//  SelectExercise.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 5/29/24.
//

import SwiftUI

struct SelectExercise: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var context

    @State private var searchText = ""
    @State private var exercises: [ExerciseJSON] = []
    @State private var selectedExerciseIDs: Set<String> = []
    @Binding var selectedExercises: [ExerciseJSON]
    @State private var completeColors: String = "red"
    
    var filteredExercises: [ExerciseJSON] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredExercises) { exercise in
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                            Text(exercise.level.capitalized)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if selectedExerciseIDs.contains(exercise.id) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if selectedExerciseIDs.contains(exercise.id) {
                        selectedExerciseIDs.remove(exercise.id)
                    } else {
                        selectedExerciseIDs.insert(exercise.id)
                    }
                }
                .background(selectedExerciseIDs.contains(exercise.id) ? Color.blue.opacity(0.1) : Color.clear)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Select Exercise")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add \(selectedExerciseIDs.count) exercises") {
                        let newExercises = exercises.filter { selectedExerciseIDs.contains($0.id) }
                        for newExercise in newExercises {
                            if !selectedExercises.contains(where: { $0.id == newExercise.id }) {
                                selectedExercises.append(newExercise)
                            }
                        }
                        selectedExerciseIDs.removeAll()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(selectedExerciseIDs.isEmpty) // Disable if no exercise is selected
                }
            }
            .searchable(text: $searchText, prompt: "Search Exercises")
            .onAppear {
                loadExercises()
            }
        }
    }
    
    func loadExercises() {
        let jsonPath = "/Users/yunho/Desktop/CSS-545-A/HW2/HW2 - Storage/ExerciseJSON"
        let fileManager = FileManager.default
        
        do {
            let jsonFiles = try fileManager.contentsOfDirectory(atPath: jsonPath)
            for fileName in jsonFiles {
                if fileName.hasSuffix(".json") {
                    let filePath = jsonPath + "/\(fileName)"
                    let fileURL = URL(fileURLWithPath: filePath)
                    if let data = try? Data(contentsOf: fileURL),
                       let decodedExercise = try? JSONDecoder().decode(ExerciseJSON.self, from: data) {
                        self.exercises.append(decodedExercise)
                    }
                }
            }
            print("Exercises loaded successfully")
        } catch {
            print("Failed to load exercises: \(error.localizedDescription)")
        }
    }
}
