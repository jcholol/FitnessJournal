//
//  ExerciseSet.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 5/29/24.
//

import SwiftUI

struct ExerciseSet: Identifiable, Codable {
    var id = UUID()
    var weight: Double
    var reps: Int
    var isComplete: Bool
}

