import SwiftUI

struct Routines: View {
    let routine: Routine
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Workout Details")
                .font(.largeTitle)
                .padding()
            
            Text("Date: \(formattedDate(routine.date))")
                .font(.headline)
                .padding(.bottom)
            
            Text("Duration: \(formattedDuration(routine.duration))")
                .font(.headline)
                .padding(.bottom)
            
            Text("Total Volume: \(String(format: "%.1f lbs", routine.volume))")
                .font(.headline)
                .padding(.bottom)
            
            Text("Total Sets: \(routine.setCount)")
                .font(.headline)
                .padding(.bottom)
        }
        List {
            VStack{
                ForEach(routine.exercises) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        if let sets = routine.sets[exercise.id] {
                            ForEach(sets.indices, id: \.self) { index in
                                let set = sets[index]
                                HStack {
                                    Text("Set \(index + 1)")
                                    Spacer()
                                    Text("Weight: \(set.weight, specifier: "%.1f") lbs")
                                    Spacer()
                                    Text("Reps: \(set.reps)")
                                    Spacer()
                                    Image(systemName: set.isComplete ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(set.isComplete ? .green : .gray)
                                }
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                }
            }
            
        }
        .navigationTitle("Workout Detail")
        .padding()
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formattedDuration(_ duration: Int) -> String {
        let days = duration / 86400
        let hours = (duration % 86400) / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        
        if days > 0 {
            return String(format: "%d days %02d hours %02d minutes %02d seconds", days, hours, minutes, seconds)
        } else if hours > 0 {
            return String(format: "%02d hours %02d minutes %02d seconds", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%02d minutes %02d seconds", minutes, seconds)
        } else {
            return String(format: "%02d seconds", seconds)
        }
    }}
