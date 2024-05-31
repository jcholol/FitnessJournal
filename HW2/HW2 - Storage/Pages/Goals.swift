import SwiftUI

struct Goals: View {
    @State private var goals = UserGoals(startingWeight: 190, currentWeight: 190, goalWeight: 160, weeklyGoal: "Lose 2 lbs per week", activityLevel: "Not Very Active", workoutsPerWeek: 0, minutesPerWorkout: 0)
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Weight Goals")) {
                    HStack {
                        Text("Starting Weight")
                        Spacer()
                        TextField("Starting Weight", value: $goals.startingWeight, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Current Weight")
                        Spacer()
                        TextField("Current Weight", value: $goals.currentWeight, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Goal Weight")
                        Spacer()
                        TextField("Goal Weight", value: $goals.goalWeight, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("Weekly Goal")) {
                    Picker("Weekly Goal", selection: $goals.weeklyGoal) {
                        Text("Lose 1 lb per week").tag("Lose 1 lb per week")
                        Text("Lose 2 lbs per week").tag("Lose 2 lbs per week")
                        Text("Maintain weight").tag("Maintain weight")
                    }
                }

                Section(header: Text("Activity Level")) {
                    Picker("Activity Level", selection: $goals.activityLevel) {
                        Text("Not Very Active").tag("Not Very Active")
                        Text("Lightly Active").tag("Lightly Active")
                        Text("Active").tag("Active")
                        Text("Very Active").tag("Very Active")
                    }
                }

                Section(header: Text("Fitness Goals")) {
                    Stepper("Workouts per Week: \(goals.workoutsPerWeek)", value: $goals.workoutsPerWeek, in: 0...7)
                    Stepper("Minutes per Workout: \(goals.minutesPerWorkout)", value: $goals.minutesPerWorkout, in: 0...180)
                }

                Section(header: Text("Nutrition Goals")) {
                    NavigationLink("Calorie, Carbs, Protein and Fat Goals", destination: Text("Nutrition details here"))
                    NavigationLink("Calorie Goals By Meal", destination: Text("Meal-specific goals here"))
                }
            }
            .navigationTitle("Goals")
        }
    }
}
