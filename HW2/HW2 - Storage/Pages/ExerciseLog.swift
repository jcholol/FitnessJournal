// Workaround for date selection https://stackoverflow.com/questions/76444745/swiftdata-predicate-do-not-work-with-date

import SwiftData
import SwiftUI

struct ExerciseLog: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @Binding var selectedDate: Date
    @State private var isCreatingExercise: Bool = false
    @State private var showingAlert = false
    @AppStorage("workoutDuration") private var duration: Int = 0
    
    @State private var showingJournal = false
    @State private var editLog: Exercise?
    @ObservedObject private var workoutManager = WorkoutManager.shared
    @State private var routines: [Routine] = []
    @State private var selectedRoutine: Routine? = nil
    
    var filteredRoutines: [Routine] {
        routines.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Quick Start")
                    .font(.headline)
                    .padding(.top, 20)
                
                Button(action: {
                    if workoutManager.isWorkoutActive {
                        showingAlert = true
                    } else {
                        isCreatingExercise = true
                        workoutManager.isWorkoutActive = true
                    }
                }) {
                    Text("Start Empty Workout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .alert("You have a workout in progress", isPresented: $showingAlert) {
                    Button("Start new workout", role: .destructive) {
                        workoutManager.isWorkoutActive = false
                        isCreatingExercise = true
                        workoutManager.isWorkoutActive = true
                        duration = 0
                    }
                    Button("Resume workout in progress") {
                        isCreatingExercise = true
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
            .padding(.horizontal)
            
            Text("Workout Sessions")
                .font(.headline)
                .padding(.top, 20)
            if filteredRoutines.isEmpty {
                ContentUnavailableView(label: {
                    Label("No Workouts", systemImage: "exclamationmark.triangle")
                }, description: {
                    Text("No workouts available for the selected date.")
                })
            } else {
                List {
                    Section(header: Text("My Workouts (\(filteredRoutines.count))")) {
                        ForEach(filteredRoutines) { routine in
                            NavigationLink(destination: Routines(routine: routine)) {
                                Text(formattedDate(routine.date))
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Workout")
        .sheet(isPresented: $isCreatingExercise) {
            NavigationStack {
                ExerciseJournal(selectedDate: $selectedDate, isWorkoutActive: $workoutManager.isWorkoutActive, duration: $duration, routines: $routines)
            }
        }
        .overlay(
            ZStack {
                if workoutManager.isWorkoutActive {
                    VStack {
                        Spacer()
                        VStack {
                            Text("Workout in Progress")
                                .foregroundColor(.white)
                            HStack {
                                Button(action: {
                                    isCreatingExercise = true
                                }) {
                                    Text("Resume")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                .padding()
                                Button(action: {
                                    workoutManager.isWorkoutActive = false
                                    duration = 0
                                }) {
                                    Text("Discard")
                                        .foregroundColor(.red)
                                        .padding()
                                        .background(Color.gray)
                                        .cornerRadius(8)
                                }
                                .padding()
                                
                            }
                        }
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                }
                Spacer()
            }
        )
        .onAppear {
            loadRoutines()
        }
    }
    
    private func loadRoutines() {
        if let data = UserDefaults.standard.data(forKey: "routines"),
           let savedRoutines = try? JSONDecoder().decode([Routine].self, from: data) {
            routines = savedRoutines
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
