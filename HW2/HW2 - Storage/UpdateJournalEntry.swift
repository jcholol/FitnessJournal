//
//  UpdateJournalEntry.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftData
import SwiftUI

struct UpdateJournalEntry: View {
    @Environment(\.dismiss) var dismiss

    @Bindable var item: MediaItem
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date", selection: $item.timestamp)
//            Toggle("isComplete?", isOn: $item.isCompleted)
            Button("Update") {
                dismiss()
            }
        }
        .navigationTitle("Update Journal Entry")
    }
}
