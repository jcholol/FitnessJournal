//
//  ContentView.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context

    @State private var calorieGoal: Double = 2000
    @State private var calories: Double = 0.0

    @State private var showingDatePicker = false
    @State private var dailyCalorieGoal: String = ""

    @State var selectedDate = Date.now
    var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd, yyyy"
        dateFormat.dateStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat
    }

    var body: some View {
        HStack {
            HStack {
                Button(action: {
                    // Subtract one day from the current `selectedDate`
                    if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) {
                        selectedDate = newDate
                    }
                }) {
                    Image(systemName: "chevron.left")
                }

                Text("\(selectedDate, formatter: dateFormatter)")
                    .font(.title)
                    .bold()

                Button(action: {
                    // Add one day to the current `selectedDate`
                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) {
                        selectedDate = newDate
                    }
                }) {
                    Image(systemName: "chevron.right")
                }
            }

            ZStack {
                Spacer()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .onChange(of: selectedDate) { _, newDate in
                        $selectedDate.wrappedValue = newDate
                    }
                    .labelsHidden()
                    .frame(width: 32, height: 32)
                    .datePickerStyle(.compact)
                    .compositingGroup()
                    .clipped()
                    .contentShape(Rectangle())

                SwiftUIWrapper {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 32, height: 32, alignment: .topLeading)
                        .scaledToFit()
                }
                .frame(width: 32, height: 32)
                .allowsHitTesting(false)
            }
        }
        HStack {
            TabView {
                Dashboard(selectedDate: $selectedDate, calorieGoal: $calorieGoal, calories: $calories)
                    .tabItem {
                        Image(systemName: "square.grid.3x3.middle.fill")
                        Text("Dashboard")
                    }
                Log(selectedDate: $selectedDate)
                    .tabItem {
                        Image(systemName: "fork.knife.circle")
                        Text("Food")
                    }
                ExerciseLog(selectedDate: $selectedDate)
                    .tabItem {
                        Image(systemName: "figure.strengthtraining.traditional")
                        Text("Exercise")
                    }
                Plans()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Diet Plans")
                    }
                More()
                    .tabItem {
                        Image(systemName: "ellipsis")
                        Text("More")
                    }
            }
        }
        .padding()
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }

    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}

#Preview {
    ContentView()
}
