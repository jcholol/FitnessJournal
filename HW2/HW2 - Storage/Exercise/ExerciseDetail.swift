import SwiftUI

struct ExerciseDetail: View {
    let exercise: ExerciseJSON
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .font(.largeTitle)
                    .padding(.bottom)
                
                Text("Level: \(exercise.level.capitalized)")
                    .font(.title2)
                    .padding(.bottom)
                
                Text("Force: \(exercise.force.capitalized)")
                    .font(.title3)
                    .padding(.bottom)
                
                Text("Mechanic: \(exercise.mechanic.capitalized)")
                    .font(.title3)
                    .padding(.bottom)
                
                Text("Equipment: \(exercise.equipment.capitalized)")
                    .font(.title3)
                    .padding(.bottom)
                
                Text("Primary Muscles: \(exercise.primaryMuscles.joined(separator: ", "))")
                    .font(.title3)
                    .padding(.bottom)
                
                Text("Secondary Muscles: \(exercise.secondaryMuscles.joined(separator: ", "))")
                    .font(.title3)
                    .padding(.bottom)
                
                Text("Instructions:")
                    .font(.title2)
                    .padding(.top)
                
                ForEach(exercise.instructions, id: \.self) { instruction in
                    Text(instruction)
                        .padding(.bottom, 2)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(exercise.name)
        }
}

