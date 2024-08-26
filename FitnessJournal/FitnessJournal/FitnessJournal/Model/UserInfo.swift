//
//  UserInfo.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 5/1/24.
//

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
