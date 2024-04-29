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
        dateFormat.dateFormat = "MMM"
        dateFormat.dateStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat
    }

    var body: some View {
        HStack {
            Text("\(selectedDate, formatter: dateFormatter)")
                .font(.title)
                .bold()

            ZStack {
                DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                    .onChange(of: selectedDate) { _, newDate in
                        $selectedDate.wrappedValue = newDate
                    }
                    .labelsHidden()
                    .frame(width: 32, height: 32)
                    .datePickerStyle(.compact)
                    .clipped()

                SwiftUIWrapper {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 32, height: 32, alignment: .topLeading)
                        .scaledToFit()
                }
                .frame(width: 32, height: 32, alignment: .center)
                .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
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
