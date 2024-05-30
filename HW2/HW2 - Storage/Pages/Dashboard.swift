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

    @State private var filteredFoods = []

    @Query var foods: [FoodItem]

    var filterFoodItem: [FoodItem] {
        return foods.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }

    var body: some View {
        VStack {
            HStack {
                let caloriesConsumed = filterFoodItem.map { $0.calories }.reduce(0, +)
                let progress: Double = 1 - (caloriesConsumed / calorieGoal)

                VStack(alignment: .leading) {
                    GroupBox {
                        Text("Remaining = Goal - Food")
                            .font(.subheadline)
                            .bold()
                        GroupBox {
                            HStack {
                                HStack {
                                    Calories(calorieGoal: calorieGoal, calories: caloriesConsumed, progress: progress)
                                    Spacer()

                                    VStack(alignment: .leading) {
                                        let goal = Image(systemName: "flag.checkered")
                                        Text("\(goal) \(calorieGoal, specifier: "%.0f")")
                                            .font(.title2)
                                        let fuel = Image(systemName: "takeoutbag.and.cup.and.straw")
                                        Text("\(fuel) \(caloriesConsumed, specifier: "%.0f")")
                                            .font(.title2)
                                    }
                                    .padding()
                                    .frame(width: 130)
                                }
                            }
                        }
                        .groupBoxStyle(.calorie)
                    } label: {
                        Label("Calories", systemImage: "medal.fill")
                    }
                    .groupBoxStyle(.calorie)
                    .padding()

                    Spacer()
                }
            }
        }
    }
}

struct CalorieGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .bold()
                .font(.title)
            configuration.content
                .font(.subheadline)
                .bold()
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

extension GroupBoxStyle where Self == CalorieGroupBoxStyle {
    static var calorie: CalorieGroupBoxStyle { .init() }
}

#Preview {
    ContentView()
}
