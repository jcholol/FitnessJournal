//
//  ExerciseRow.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import SwiftUI

struct ExerciseRow: View {
    let exercise: Exercise

    var body: some View {
        HStack {
            Text(exercise.name)
            Spacer()
            Text(exercise.duration, format: .number)
//            Text(exercise.calories, format: .number)
        }
    }
}
