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
