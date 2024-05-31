import Foundation
import SwiftData

@Model
class UserGoals {
    var startingWeight: Double
    var currentWeight: Double
    var goalWeight: Double
    var weeklyGoal: String
    var activityLevel: String
    var workoutsPerWeek: Int
    var minutesPerWorkout: Int

    init(startingWeight: Double, currentWeight: Double, goalWeight: Double, weeklyGoal: String, activityLevel: String, workoutsPerWeek: Int, minutesPerWorkout: Int) {
        self.startingWeight = startingWeight
        self.currentWeight = currentWeight
        self.goalWeight = goalWeight
        self.weeklyGoal = weeklyGoal
        self.activityLevel = activityLevel
        self.workoutsPerWeek = workoutsPerWeek
        self.minutesPerWorkout = minutesPerWorkout
    }
}
