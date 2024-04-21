//
//  FoodRow.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/20/24.
//

import SwiftUI

struct FoodRow: View {
    var food: Food

    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 50, height: 50)
                .opacity(0)
            Text(food.name)

            Spacer()
        }
    }
}

#Preview() {
    let modelData = ModelData()

    return Group {
        FoodRow(food: modelData.foods.first ?? Food(id: 0, name: "Sample Food", calories: 0, serving_size_g: 0, fat_total_g: 0, fat_saturated_g: 0, protein_g: 0, sodium_mg: 0, potassium_mg: 0, cholesterol_mg: 0, carbohydrates_total_g: 0, fiber_g: 0, sugar_g: 0))
        FoodRow(food: modelData.foods.dropFirst().first ?? Food(id: 1, name: "Another Sample Food", calories: 0, serving_size_g: 0, fat_total_g: 0, fat_saturated_g: 0, protein_g: 0, sodium_mg: 0, potassium_mg: 0, cholesterol_mg: 0, carbohydrates_total_g: 0, fiber_g: 0, sugar_g: 0))
    }
}
