import Foundation
import HealthKit

extension Date {
    static func startOfDay(for date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    static func endOfDay(for date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: startOfDay(for: date))!
    }
}

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var activities: [String: Activity] = [:]
    @Published var stepGoal: Double = 10000 // Default step goal
    
    init() {
        let steps = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let healthTypes: Set = [steps]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("error requesting health data authorization")
            }
        }
        
        // Fetch the step goal from UserDefaults
        fetchStepGoal()
    }
    
    func fetchStepGoal() {
        if let savedGoalsData = UserDefaults.standard.data(forKey: "goals"),
           let savedGoals = try? JSONDecoder().decode(Goals.self, from: savedGoalsData) {
            self.stepGoal = savedGoals.stepGoal
        }
    }
    
    func fetchSteps(for date: Date) {
        clearActivities()
        
        let steps = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let startOfDay = Date.startOfDay(for: date)
        let endOfDay = Date.endOfDay(for: date)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error {
                print("error fetching steps for selected date: \(error.localizedDescription)")
                return
            }
            
            guard let result = result, let quantity = result.sumQuantity() else {
                print("No data available for the specified predicate.")
                return
            }
            
            let stepCount = quantity.doubleValue(for: HKUnit.count())
            let activity = Activity(id: Int(date.timeIntervalSince1970), title: "Steps:", subtitle: "Goal: \(Int(self.stepGoal))", image: "figure.walk", amount: stepCount.formattedString() ?? "0")
            
            DispatchQueue.main.async {
                self.activities["stepsFor\(date)"] = activity
            }

            print(stepCount)
        }
        healthStore.execute(query)
    }
    
    func clearActivities() {
        DispatchQueue.main.async {
            self.activities.removeAll()
        }
    }
}

extension Double {
    func formattedString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))
    }
}
