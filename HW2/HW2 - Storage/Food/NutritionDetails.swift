//
//  NutritionDetails.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/20/24.
//

import SwiftUI

struct NutritionDetails: View {
    var food: Food

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(food.name)
                    .font(.title)

                HStack {
                    Text("Calories: " + String(food.calories))
                    Spacer()
                    Text("Serving Size: " + String(food.serving_size_g))
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text(String(food.fat_total_g))
                    .font(.title2)
                Text(String(food.fiber_g))
            }
            .padding()
        }
        .navigationTitle(food.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//
// #Preview {
//    let modelData = ModelData()
//
//    NutritionDetails(Food(id: 0, name: "Sample Food", calories: 0, serving_size_g: 0, fat_total_g: 0, fat_saturated_g: 0, protein_g: 0, sodium_mg: 0, potassium_mg: 0, cholesterol_mg: 0, carbohydrates_total_g: 0, fiber_g: 0, sugar_g: 0))
// }
