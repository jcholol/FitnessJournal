//
//  Dashboard.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//  SOURCE: Calendar: https://stackoverflow.com/questions/65797437/how-to-make-a-button-or-any-other-element-show-swiftuis-datepicker-popup-on-t
//  DateFormatter: https://stackoverflow.com/questions/63663728/how-to-display-yesterday-today-and-tomorrow-with-dateformatter
//
//

import SwiftData
import SwiftUI

struct Dashboard: View {
    @Environment(\.modelContext) var context

    @State private var calorieGoal: Int = 2000
    @State private var calories: Double = 0.0

    @State private var showingDatePicker = false
    @State private var dailyCalorieGoal: String = ""

    var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM"
        dateFormat.dateStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat
    }

    @State private var selectedDate = Date()
    @Query var foods: [FoodItem]
    @Query var exercise: [Exercise]

    @State private var filteredFoods = []
    @State private var filteredExercise = []

    var body: some View {
        let progress: Double = 1 - (calories / 1000)
        VStack {
            HStack {
                Text("\(selectedDate, formatter: dateFormatter)")
                    .font(.title)
                    .bold()

                ZStack {
                    DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
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
                Calories(calorieGoal: calorieGoal, progress: progress)
                Spacer()
                    .frame(width: 150, height: 20)
            }
            .padding()

            Spacer().frame(height: 30)

            Spacer()
        }
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
    Dashboard()
}
