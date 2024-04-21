//
//  FoodList.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftUI

struct FoodList: View {
    @StateObject private var modelData = ModelData()

    var body: some View {
        NavigationSplitView {
            List(modelData.foods) { food in
                NavigationLink {
                    NutritionDetails(food: food)
                } label: {
                    FoodRow(food: food)
                }
            }
            .navigationTitle("Journal")
        } detail: {
            Text("select food item")
        }
    }
}

#Preview {
    FoodList()
}
