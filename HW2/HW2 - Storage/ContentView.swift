import SwiftData
import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isLoggedIn = false
    @EnvironmentObject var userAuth: UserAuth
    @AppStorage("isDarkMode") var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    @Environment(\.modelContext) var context
    
    @State private var isProfileOpen: Bool = false
    @State var selectedDate = Date.now
    @State private var showingDatePicker = false
    @State private var dailyCalorieGoal: String = ""
    
    // Load and save calorieGoal using UserDefaults
    @State private var calorieGoal: Double = UserDefaults.standard.double(forKey: "calorieGoal") == 0 ? 2000 : UserDefaults.standard.double(forKey: "calorieGoal")
    
    var dateFormatter: DateFormatter {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd, yyyy"
        dateFormat.dateStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat
    }
    
    var body: some View {
        Group {
            if !isLoggedIn {
                Login()
            } else {
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
                                    .frame(width: 32, height: 32)
                                    .datePickerStyle(.compact)
                                    .compositingGroup()
                                    .clipped()
                                    .contentShape(Rectangle())
                                
                                SwiftUIWrapper {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 32, height: 32, alignment: .topLeading)
                                        .scaledToFit()
                                }
                                .frame(width: 32, height: 32)
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
                    Dashboard(selectedDate: $selectedDate, calorieGoal: $calorieGoal)
                        .tabItem {
                            Label("Dashboard", systemImage: "square.grid.3x3.middle.fill")
                        }
                    Log(selectedDate: $selectedDate)
                        .tabItem {
                            Label("Food", systemImage: "fork.knife.circle")
                        }
                    ExerciseLog(selectedDate: $selectedDate)
                        .tabItem {
                            Label("Exercise", systemImage: "figure.strengthtraining.traditional")
                        }
                    //                Plans()
                    //                    .tabItem {
                    //                        Image(systemName: "pencil.and.list.clipboard")
                    //                        Text("Diet Plans")
                    //                    }
                }
                .sheet(isPresented: $isProfileOpen) {
                    NavigationStack {
                        Profiles(isDarkMode: $isDarkMode)
                            .toolbar {
                                ToolbarItem {
                                    Button(action: {
                                        isProfileOpen = false
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
        .onAppear {
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    isLoggedIn = true
                } else {
                    isLoggedIn = false
                }
            }
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
    ContentView()
}
