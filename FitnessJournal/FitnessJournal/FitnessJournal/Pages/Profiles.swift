import SwiftUI

struct Profiles: View {
    @Binding var isDarkMode: Bool
    @Binding var calorieGoal: Double
    @Binding var stepGoal: Double

    var body: some View {
        NavigationView {
            Form {
                ProfileHeader()

                Section(header: Text("App Appearance")) {
                    AppAppearanceToggle(isDarkMode: $isDarkMode)
                }

                Section(header: Text("Fitness Information")) {
                    GoalsNavigationLink(calorieGoal: $calorieGoal, stepGoal: $stepGoal)
                }
            }
            .navigationTitle("Account Settings")
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ProfileHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text("Local User").font(.title2)
                //Text("User Email")
            }
        }
    }
}

struct AppAppearanceToggle: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        HStack {
            Settings(iconColor: .blue, iconName: "sun.max.fill")
            Toggle("App Appearance", isOn: $isDarkMode)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
    }
}

struct GoalsNavigationLink: View {
    @Binding var calorieGoal: Double
    @Binding var stepGoal: Double

    var body: some View {
        NavigationLink(destination: GoalsView(calorieGoal: $calorieGoal, stepGoal: $stepGoal).environmentObject(GoalsViewModel())) {
            HStack {
                Settings(iconColor: .red, iconName: "target")
                Text("Goals")
            }
        }
    }
}

struct Settings: View {
    let iconColor: Color
    let iconName: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4).fill(iconColor)
                .frame(width: 28, height: 28)
            Image(systemName: iconName).foregroundColor(.white)
        }
    }
}

extension UserDefaults {
    func loadGoals() -> Goals? {
        if let savedGoalsData = data(forKey: "goals"),
           let savedGoals = try? JSONDecoder().decode(Goals.self, from: savedGoalsData) {
            return savedGoals
        }
        return nil
    }
}

struct GoalsView: View {
    @EnvironmentObject var viewModel: GoalsViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var calorieGoal: Double
    @Binding var stepGoal: Double

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Set Goals")) {
                    HStack {
                        Text("Daily Calorie Goal")
                        Spacer()
                        TextField("Calorie Goal", value: $calorieGoal, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Daily Step Goal")
                        Spacer()
                        TextField("Step Goal", value: $stepGoal, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.setGoals(calorieGoal: calorieGoal, stepGoal: stepGoal)
                            dismiss()
                        }) {
                            Text("Save Goals")
                        }
                    }
                }
            }
        }
        .onAppear {
            calorieGoal = viewModel.goals.calorieGoal
            stepGoal = viewModel.goals.stepGoal
        }
        .navigationTitle("Goals")
    }
}

class GoalsViewModel: ObservableObject {
    @Published var goals: Goals

    init() {
        // Initialize with default values
        self.goals = Goals(calorieGoal: 2000, stepGoal: 10000)
        // Update goals with values from UserDefaults
        if let savedGoals = getGoals() {
            self.goals = savedGoals
        }
    }

    func setGoals(calorieGoal: Double, stepGoal: Double) {
        goals.calorieGoal = calorieGoal
        goals.stepGoal = stepGoal
        saveGoals(goals)
    }

    private func getGoals() -> Goals? {
        if let savedGoalsData = UserDefaults.standard.data(forKey: "goals"),
           let savedGoals = try? JSONDecoder().decode(Goals.self, from: savedGoalsData) {
            return savedGoals
        }
        return nil
    }

    private func saveGoals(_ goals: Goals) {
        if let encoded = try? JSONEncoder().encode(goals) {
            UserDefaults.standard.set(encoded, forKey: "goals")
        }
    }
}

struct Goals: Codable {
    var calorieGoal: Double
    var stepGoal: Double
}
