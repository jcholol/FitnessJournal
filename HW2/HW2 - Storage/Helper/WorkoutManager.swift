import SwiftUI
import SwiftData

class WorkoutManager: ObservableObject {
    static let shared = WorkoutManager()
    @Published var exercises: [ExerciseSet] = []
    @Published var volume: Double = 0
    @Published var setCount: Int = 0
    @Published var isWorkoutActive: Bool = false
    
    func updateGlobalVolumeAndCount() {
        let completedSets = exercises.compactMap { $0 }.filter { $0.isComplete }
        setCount = completedSets.count
        volume = completedSets.reduce(0) { $0 + $1.weight * Double($1.reps) }
    }
}

