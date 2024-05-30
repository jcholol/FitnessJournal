//
//  ExerciseJournal.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import SwiftData
import SwiftUI

struct ExerciseJournal: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedDate: Date
    @Binding var isWorkoutActive: Bool
    @Binding var duration: Int
    
    @State private var timer: Timer?
    @State var volume: Double = 0.0
    @State var setCount: Int = 0
    @State private var showingAddExercise = false
    @State private var selectedExercises: [ExerciseJSON] = [] {
        didSet {
            saveSelectedExercises()
        }
    }
    @Binding var routines: [Routine]
    @State private var selectedRoutine: Routine? = nil
    @State var sets: [ExerciseSet] = []

    var body: some View {
        VStack {
            HStack {
                Text("Log Workout")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    finishWorkout()
                    dismiss()
                }) {
                    Text("Finish")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            
            HStack {
                VStack {
                    Text("Duration")
                        .font(.subheadline)
                    Text(formattedDuration)
                        .foregroundColor(.blue)
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Volume")
                        .font(.subheadline)
                    Text(String(format: "%.1f lbs", volume))
                        .foregroundColor(.blue)
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Sets")
                        .font(.subheadline)
                    Text(String(format: "%00d", setCount))
                        .foregroundColor(.blue)
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            
            Spacer()
            
            VStack {
                if !selectedExercises.isEmpty {
                    List {
                        ForEach(selectedExercises) { exercise in
                            NavigationLink(destination: LogExercise(exercise: exercise, volume: $volume, setCount: $setCount, sets: $sets)) {
                                VStack(alignment: .leading) {
                                    Text(exercise.name)
                                        .font(.headline)
                                }
                            }
                        }
                        .onDelete(perform: deleteExercise)
                    }
                }
                
                Button(action: {
                    showingAddExercise = true
                }) {
                    Text("+ Add Exercise")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.bottom)
                
                HStack {
                    Button(action: {
                        resetWorkout()
                        dismiss()
                    }) {
                        Text("Discard Workout")
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingAddExercise) {
            SelectExercise(selectedExercises: $selectedExercises)
        }
        .overlay {
            if selectedExercises.isEmpty {
                ContentUnavailableView(label: {
                    Label("Get started", systemImage: "dumbbell")
                }, description: {
                    Text("Add an exercise to start your workout")
                }, actions: {
                    Button("Add Exercise") {
                        showingAddExercise = true
                    }
                })
            }
        }
        .onAppear {
            startTimer()
            loadSelectedExercises()
        }
        .onDisappear {
            stopTimer()
            saveSelectedExercises()
        }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        offsets.forEach { index in
            let exercise = selectedExercises[index]
            UserDefaults.standard.removeObject(forKey: "\(exercise.id)_sets")
        }
        selectedExercises.remove(atOffsets: offsets)
        saveSelectedExercises()
    }
    
    private func finishWorkout() {
        let routine = Routine(
            id: UUID(),
            date: selectedDate,
            duration: duration,
            volume: volume,
            setCount: setCount,
            exercises: selectedExercises,
            sets: selectedExercises.reduce(into: [String: [ExerciseSet]]()) { result, exercise in
                if let data = UserDefaults.standard.data(forKey: "\(exercise.id)_sets"),
                   let savedSets = try? JSONDecoder().decode([ExerciseSet].self, from: data) {
                    result[exercise.id] = savedSets
                }
            }
        )
        routines.append(routine)
        saveRoutines()
        resetWorkout()
    }
    
    private func resetWorkout() {
        volume = 0
        setCount = 0
        duration = 0
        isWorkoutActive = false
        stopTimer()
        clearAllSets() 
        selectedExercises.removeAll()
    }
    
    private func clearAllSets() {
        for exercise in selectedExercises {
            UserDefaults.standard.removeObject(forKey: "\(exercise.id)_sets")
        }
        sets.removeAll()
    }
    
    private func saveRoutines() {
        if let data = try? JSONEncoder().encode(routines) {
            UserDefaults.standard.set(data, forKey: "routines")
        }
    }
    
    private func saveSelectedExercises() {
        if let data = try? JSONEncoder().encode(selectedExercises) {
            UserDefaults.standard.set(data, forKey: "selectedExercises")
        }
    }
    
    private func loadSelectedExercises() {
        if let data = UserDefaults.standard.data(forKey: "selectedExercises"),
           let savedExercises = try? JSONDecoder().decode([ExerciseJSON].self, from: data) {
            selectedExercises = savedExercises
        }
    }
    
    var formattedDuration: String {
        let days = duration / 86400
        let hours = (duration % 86400) / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        
        if days > 0 {
            return String(format: "%d:%02d:%02d:%02d", days, hours, minutes, seconds)
        } else if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02ds", seconds)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            duration += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
