//
//  Routine.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 5/29/24.
//

import Foundation

struct Routine: Identifiable, Codable {
    let id: UUID
    let date: Date
    let duration: Int
    let volume: Double
    let setCount: Int
    let exercises: [ExerciseJSON]
    let sets: [String: [ExerciseSet]]
}
