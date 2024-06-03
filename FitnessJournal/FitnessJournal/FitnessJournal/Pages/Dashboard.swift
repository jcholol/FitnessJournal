import SwiftData
import SwiftUI

struct Dashboard: View {
    @Environment(\.modelContext) var context
    
    @Binding var selectedDate: Date
    @Binding var calorieGoal: Double
    @Binding var stepGoal: Double
    
    @State private var filteredFoods = []
    @State private var filteredExercise = []
    
    @Query var foods: [FoodItem]
    @Query var exercises: [Exercise]
    @EnvironmentObject var manager: HealthManager

    var filterExercise: [Exercise] {
        return exercises.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }
    
    var filterFoodItem: [FoodItem] {
        return foods.filter { Calendar.current.compare($0.date, to: selectedDate, toGranularity: .day) == .orderedSame }
    }
    
    var body: some View {
        VStack {
            HStack {
                let caloriesConsumed = filterFoodItem.map { $0.calories }.reduce(0, +)
                let caloriesBurned = 100 /* filterExercise.map { $0.calories }.reduce(0, +) */
                let progress: Double = 1 - (caloriesConsumed / calorieGoal)
                
                VStack(alignment: .leading) {
                    GroupBox {
                        Text("Remaining = Goal - Food")
                            .font(.subheadline)
                            .bold()
                        GroupBox {
                            HStack {
                                HStack {
                                    Calories(calorieGoal: $calorieGoal, calories: caloriesConsumed, progress: progress)
                                    Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        let goal = Image(systemName: "flag.checkered")
                                        Text("\(goal) \(calorieGoal, specifier: "%.0f")")
                                            .font(.title2)
                                        let fuel = Image(systemName: "takeoutbag.and.cup.and.straw")
                                        Text("\(fuel) \(caloriesConsumed, specifier: "%.0f")")
                                            .font(.title2)
//                                        let burn = Image(systemName: "figure.cooldown")
//                                        Text("\(burn) \(caloriesBurned, specifier: "%.0f")")
//                                            .font(.title2)
                                    }
                                    .padding()
                                    .frame(width: 100)
                                }
                            }
                        }
                        .groupBoxStyle(.calorie)
                    } label: {
                        Label("Calories", systemImage: "medal.fill")
                    }
                    .groupBoxStyle(.calorie)
                    
                    VStack{
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                            ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id }), id: \.key) { item in
                                HealthCard(activity: item.value, stepGoal: $stepGoal)
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .onAppear {
                        manager.fetchSteps(for: selectedDate)
                        fetchCalorieGoal()
                    }
                    .onChange(of: selectedDate) { _, newDate in
                        manager.fetchSteps(for: newDate)
                    }
                    Spacer()

                }
            }
        }
    }
    
    private func fetchCalorieGoal() {
        if let savedGoalsData = UserDefaults.standard.data(forKey: "goals"),
           let savedGoals = try? JSONDecoder().decode(Goals.self, from: savedGoalsData) {
            self.calorieGoal = savedGoals.calorieGoal
        }
    }
}

struct CalorieGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .bold()
                .font(.title)
            configuration.content
                .font(.subheadline)
                .bold()
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

extension GroupBoxStyle where Self == CalorieGroupBoxStyle {
    static var calorie: CalorieGroupBoxStyle { .init() }
}
