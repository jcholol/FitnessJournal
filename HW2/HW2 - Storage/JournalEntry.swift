//
//  JournalEntry.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftUI

struct JournalEntry: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State private var item = MediaItem()

    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date", selection: $item.timestamp)
//            Toggle("Complete?", isOn: $item.isCompleted)
            Button("Create") {
                withAnimation {
                    context.insert(item)
                }
                dismiss()
            }
        }
        .navigationTitle("Create Entry")
    }
}
