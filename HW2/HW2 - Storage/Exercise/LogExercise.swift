//
//  LogExercise.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 5/29/24.
//

import SwiftUI

struct LogExercise: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var workoutManager = WorkoutManager.shared

    let exercise: ExerciseJSON
    @Binding var volume: Double
    @Binding var setCount: Int
    @Binding var sets: [ExerciseSet]
    
    var body: some View {
        VStack {
            NavigationLink(destination: ExerciseDetail(exercise: exercise)) {
                Text(exercise.name)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom, 5)
            }
            
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("Set")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                    Text("Weight")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                    Text("Reps")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                    Text("Complete")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
            }
            List {
                ForEach(sets.indices, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)")
                            .frame(maxWidth: .infinity)
                        TextField("0", value: $sets[index].weight, format: .number)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity)
                        TextField("0", value: $sets[index].reps, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: .infinity)
                        Button(action: {
                            sets[index].isComplete.toggle()
                            updateVolumeAndCount()
                            saveSets()
                        }) {
                            Image(systemName: sets[index].isComplete ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(sets[index].isComplete ? .green : .gray)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .onDelete { indexSet in
                    sets.remove(atOffsets: indexSet)
                    updateVolumeAndCount()
                    saveSets()
                }
            }
            .listStyle(PlainListStyle())
        }
        
        Button(action: {
            sets.append(ExerciseSet(weight: 0, reps: 0, isComplete: false))
            updateVolumeAndCount()
            saveSets()
        }) {
            Text("+ Add Set")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    saveSets()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding()
        .onAppear {
            if workoutManager.isWorkoutActive {
                loadSets()
            }
        }
        .onDisappear {
            if workoutManager.isWorkoutActive {
                updateVolumeAndCount()
                saveSets()
            } else {
                sets.removeAll()
                print(sets)
            }
        }
    }
    
    private func saveSets() {
        if let data = try? JSONEncoder().encode(sets) {
            UserDefaults.standard.set(data, forKey: "\(exercise.id)_sets")
        }
    }
    
    private func loadSets() {
        if let data = UserDefaults.standard.data(forKey: "\(exercise.id)_sets"),
           let savedSets = try? JSONDecoder().decode([ExerciseSet].self, from: data) {
            sets = savedSets
            updateVolumeAndCount()
        }
    }
    
    private func updateVolumeAndCount() {
        setCount = sets.count
        volume = sets.reduce(0) { $0 + $1.weight * Double($1.reps) }
    }
}

