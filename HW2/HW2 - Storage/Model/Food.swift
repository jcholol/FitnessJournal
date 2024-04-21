//
//  Food.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/20/24.
//

import Foundation
import SwiftUI

struct Food: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let calories: Double
    let serving_size_g: Double
    let fat_total_g: Double
    let fat_saturated_g: Double
    let protein_g: Double
    let sodium_mg: Double
    let potassium_mg: Double
    let cholesterol_mg: Double
    let carbohydrates_total_g: Double
    let fiber_g: Double
    let sugar_g: Double
}
