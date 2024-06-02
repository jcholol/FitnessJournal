//
//  Calories.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/19/24.
//

import SwiftUI

struct Calories: View {
    @State var width: CGFloat = 175
    @Binding var calorieGoal: Double
    var calories: Double
    let progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.pink.opacity(0.5), lineWidth: 20)
                .frame(width: width)
            Circle()
                .trim(from: progress, to: 1)
                .stroke(Color.pink,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .frame(width: width)
                .rotationEffect(.degrees(90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .animation(.easeOut, value: progress)
            VStack {
                Text(String(format: "%.0f", calorieGoal - calories))
                    .bold()
                    .font(.title)
                Text("remaining")
                    .bold()
                    .font(.title)
            }
        }
    }
}
