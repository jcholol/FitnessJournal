//
//  ExerciseJournal.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/27/24.
//

import SwiftUI

struct ExerciseJournal: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context

    @Binding var selectedDate: Date
    @State private var duration: Int = 0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            HStack {
                Text("Log Workout")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // Action for timer
                }) {
                    Image(systemName: "timer")
                }
                .padding()
                
                Button(action: {
                    // Action to finish workout
                }) {
                    Text("Finish")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            
            HStack {
                VStack {
                    Text("Duration")
                        .font(.subheadline)
                    Text(formattedDuration)
                        .foregroundColor(.blue)
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Volume")
                        .font(.subheadline)
                    Text("0 lbs")
                        .foregroundColor(.blue)
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Sets")
                        .font(.subheadline)
                    Text("0")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            
            Spacer()
            
            VStack {
                Image(systemName: "dumbbell")
                    .font(.largeTitle)
                    .padding()
                
                Text("Get started")
                    .font(.title2)
                    .padding(.bottom, 1)
                
                Text("Add an exercise to start your workout")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                
                Button(action: {
                    // Action to add exercise
                }) {
                    Text("+ Add Exercise")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        // Action for settings
                    }) {
                        Text("Settings")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // Action to discard workout
                    }) {
                        Text("Discard Workout")
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .onAppear {
            startTimer()
        }
    }

    var formattedDuration: String {
        let days = duration / 86400
        let hours = (duration % 86400) / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60

        if days > 0 {
            return String(format: "%d:%02d:%02d:%02d", days, hours, minutes, seconds)
        } else if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02d", seconds)
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            duration += 1
        }
    }
}
