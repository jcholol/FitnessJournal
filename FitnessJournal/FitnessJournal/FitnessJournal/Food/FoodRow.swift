//
//  FoodRow.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import SwiftUI

struct FoodRow: View {
    let food: FoodItem

    var body: some View {
        HStack {
            Text(food.name)
            Spacer()
            Text(food.calories, format: .number)
        }
    }
}
