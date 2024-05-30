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
    var previousWeight: Double
    var previousRep: Int
    
    init(name: String, previousWeight: Double, previousRep: Int) {
        self.name = name
        self.previousWeight = previousWeight
        self.previousRep = previousRep
    }
}
