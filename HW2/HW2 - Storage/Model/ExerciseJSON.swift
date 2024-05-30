//
//  ExerciseJSON.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 5/29/24.
//

import Foundation

struct ExerciseJSON: Identifiable, Codable {
    let id: String
    let name: String
    let force: String
    let level: String
    let mechanic: String
    let equipment: String
    let primaryMuscles: [String]
    let secondaryMuscles: [String]
    let instructions: [String]
    let category: String
    let images: [String]
}
