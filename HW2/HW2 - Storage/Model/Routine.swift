import Foundation

struct Routine: Identifiable, Codable {
    let id: UUID
    let date: Date
    let duration: Int
    let volume: Double
    let setCount: Int
    let exercises: [ExerciseJSON]
    let sets: [String: [ExerciseSet]]
}
