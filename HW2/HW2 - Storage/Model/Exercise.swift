//
//  Exercise.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import Foundation
import SwiftData

@Model
class Exercise {
    var name: String
    var duration: Int
    var date: Date

    init(name: String, duration: Int, date: Date) {
        self.name = name
        self.duration = duration
        self.date = date
    }
}
