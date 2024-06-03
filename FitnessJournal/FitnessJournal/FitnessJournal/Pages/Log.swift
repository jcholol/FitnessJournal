import SwiftData
import SwiftUI

struct Log: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context

    @Binding var selectedDate: Date
    @State private var showingJournal = false
    @State private var editLog: FoodItem?

    @Query var foods: [FoodItem]

    var filterFoodItem: [FoodItem] {
        return foods.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }

    var body: some View {
        NavigationStack {
            List {
                if !filterFoodItem.filter({ isInTimeRange($0.date, start: 8, end: 11) }).isEmpty {
                    foodSection(title: "Breakfast", items: filterFoodItem.filter { isInTimeRange($0.date, start: 8, end: 11) })
                }
                if !filterFoodItem.filter({ isInTimeRange($0.date, start: 12, end: 15) }).isEmpty {
                    foodSection(title: "Lunch", items: filterFoodItem.filter { isInTimeRange($0.date, start: 12, end: 15) })
                }
                if !filterFoodItem.filter({ isInTimeRange($0.date, start: 18, end: 21) }).isEmpty {
                    foodSection(title: "Dinner", items: filterFoodItem.filter { isInTimeRange($0.date, start: 18, end: 21) })
                }
                if !filterFoodItem.filter({ isInSnackTime($0.date) }).isEmpty {
                    foodSection(title: "Snack", items: filterFoodItem.filter { isInSnackTime($0.date) })
                }
            }
            .navigationTitle("Food Journal")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingJournal) { JournalEntry(selectedDate: $selectedDate) }
            .sheet(item: $editLog) { food in
                UpdateJournalEntry(food: food)
            }
            .toolbar {
                if !filterFoodItem.isEmpty {
                    Button {
                        showingJournal = true
                    } label: {
                        Label("Add Food", systemImage: "plus")
                    }
                }
            }
            .overlay {
                if filterFoodItem.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No food logged", systemImage: "rectangle.and.pencil.and.ellipsis")
                    }, description: {
                        Text("Begin journaling your food intake")
                    }, actions: {
                        Button("Add Food") {
                            showingJournal = true
                        }
                    })
                }
            }
        }
    }

    private func foodSection(title: String, items: [FoodItem]) -> some View {
        Section(header: Text(title)) {
            ForEach(items) { food in
                FoodRow(food: food)
                    .onTapGesture {
                        editLog = food
                    }
            }
            .onDelete { foodIndex in
                for index in foodIndex {
                    context.delete(items[index])
                }
            }
        }
    }

    private func isInTimeRange(_ date: Date, start: Int, end: Int) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        return hour >= start && hour < end
    }

    private func isInSnackTime(_ date: Date) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        return (hour >= 0 && hour < 8) || (hour >= 11 && hour < 12) || (hour >= 15 && hour < 18) || (hour >= 21 && hour <= 23)
    }
}
