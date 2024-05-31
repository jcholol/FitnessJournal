import SwiftUI

struct ExerciseSet: Identifiable, Codable {
    var id = UUID()
    var weight: Double
    var reps: Int
    var isComplete: Bool
}

