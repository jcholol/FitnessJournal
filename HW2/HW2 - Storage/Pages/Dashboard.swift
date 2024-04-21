//
//  Dashboard.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Dashboard: View {
    @State private var foodLog: String = ""
    @State private var exerciseLog: String = ""
    @State private var calorieGoal: Int = 2000
    @State private var calories: Double = 0.0
    @State private var isAddingFood = false
    @State private var isAddingExercise = false
    @State private var searchText = ""

    var body: some View {
        let progress: Double = 1 - (calories / 1000)
        VStack {
            HStack {
                Text("Today")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                    .frame(width: 250, height: 100)
            }
            HStack {
                Calories(calorieGoal: calorieGoal, progress: progress)
                Spacer()
                    .frame(width: 150, height: 20)
            }
            .padding()

            Spacer().frame(height: 30)

            VStack(alignment: .leading) {
                Divider()
                Button("Add Food") {
                    isAddingFood.toggle()
                }
                .bold()
                .padding(.leading, 85)
                Divider()
                Button("Add Exercise") {
                    isAddingExercise.toggle()
                }
                .padding(.leading, 85)
                .bold()
                Divider()
            }

            Spacer()
        }
    }
}

#Preview {
    Dashboard()
}
