//
//  Dashboard.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//  SOURCE: Calendar: https://stackoverflow.com/questions/65797437/how-to-make-a-button-or-any-other-element-show-swiftuis-datepicker-popup-on-t
//  DateFormatter: https://stackoverflow.com/questions/63663728/how-to-display-yesterday-today-and-tomorrow-with-dateformatter
//
//

import SwiftData
import SwiftUI

struct Dashboard: View {
    @Environment(\.modelContext) var context

    @Binding var selectedDate: Date
    @Binding var calorieGoal: Double
    @Binding var calories: Double

    @Query var foods: [FoodItem]
    @Query var exercises: [Exercise]

    @State private var filteredFoods = []
    @State private var filteredExercise = []

    var filterExercise: [Exercise] {
        return exercises.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }

    var filterFoodItem: [FoodItem] {
        return foods.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }

    var body: some View {
        VStack {
            let calories = filterFoodItem.map { $0.calories }.reduce(0, +)
            let progress: Double = 1 - (calories / calorieGoal)
            VStack(alignment: .leading) {
                Text("Calories")
                    .font(.title)
                    .bold()
                Text("Remaining = Goal - Food")
                    .font(.subheadline)
                    .bold()
                HStack {
                    Calories(calorieGoal: calorieGoal, calories: calories, progress: progress)
                    Spacer()
                        .frame(width: 150, height: 20)
                }
                .padding()

                Spacer().frame(height: 30)

                Spacer()
            }
        }
    }
}
