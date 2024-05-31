import SwiftUI

struct FoodRow: View {
    let food: FoodItem

    var body: some View {
        HStack {
            Text(food.name)
            Spacer()
            Text(food.calories, format: .number)
        }
    }
}
