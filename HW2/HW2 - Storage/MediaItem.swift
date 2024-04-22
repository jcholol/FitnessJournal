//
//  MediaItem.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import Foundation
import SwiftData

@Model
final class MediaItem {
    var title: String
    var timestamp: Date
    var isCompleted: Bool

    init(title: String = "",
         timestamp: Date = .now,
         isCompleted: Bool = false)
    {
        self.title = title
        self.timestamp = timestamp
        self.isCompleted = isCompleted
    }
}
