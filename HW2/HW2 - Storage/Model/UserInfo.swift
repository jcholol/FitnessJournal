import Foundation
import SwiftData

@Model
class UserInfo {
    var name: String
    var isDarkMode: Bool

    init(name: String, isDarkMode: Bool) {
        self.name = name
        self.isDarkMode = isDarkMode
    }
}
