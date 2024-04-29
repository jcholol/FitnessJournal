//
//  FoodItem.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/26/24.
//

import Foundation
import SwiftData

@Model
class FoodItem {
    var name: String
    var calories: Double
    var date: Date

    init(name: String, calories: Double, date: Date) {
        self.name = name
        self.calories = calories
        self.date = date
    }
}
