import SwiftData
import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode")

    @Environment(\.modelContext) var context

    @State private var isProfileOpen: Bool = false
    @State var selectedDate = Date.now
    @State private var showingDatePicker = false
    @State private var dailyCalorieGoal: String = ""

    // Load and save calorieGoal using UserDefaults
    @State private var calorieGoal: Double = UserDefaults.standard.double(forKey: "calorieGoal") == 0 ? 2000 : UserDefaults.standard.double(forKey: "calorieGoal")

    // Load and save stepGoal using UserDefaults
    @State private var stepGoal: Double = UserDefaults.standard.double(forKey: "stepGoal") == 0 ? 10000 : UserDefaults.standard.double(forKey: "stepGoal")

    var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd, yyyy"
        dateFormat.dateStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat
    }

    var body: some View {
        ZStack {
            VStack {
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
                            .frame(width: 20, height: 20)
                            .datePickerStyle(.compact)
                            .compositingGroup()
                            .clipped()
                            .contentShape(Rectangle())

                        SwiftUIWrapper {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .topLeading)
                                .scaledToFit()
                        }
                        .frame(width: 20, height: 20)
                        .allowsHitTesting(false)
                    }
                    .ignoresSafeArea()
                }
            }

            Button(action: {
                isProfileOpen = true
            }) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        TabView {
            Dashboard(selectedDate: $selectedDate, calorieGoal: $calorieGoal, stepGoal: $stepGoal)
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

        }
        .sheet(isPresented: $isProfileOpen) {
            NavigationStack {
                Profiles(isDarkMode: $isDarkMode, calorieGoal: $calorieGoal, stepGoal: $stepGoal)
                    .toolbar {
                        ToolbarItem {
                            Button(action: {
                                isProfileOpen = false
                                // Save the updated goals to UserDefaults
                                UserDefaults.standard.set(calorieGoal, forKey: "calorieGoal")
                                UserDefaults.standard.set(stepGoal, forKey: "stepGoal")
                            }) {
                                Text("Done")
                            }
                        }
                    }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
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
