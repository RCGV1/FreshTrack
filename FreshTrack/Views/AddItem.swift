import CoreML
import SwiftUI

struct ContentView: View {
    let autoCompleteTermsClass = AutoCompleteTerms()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var enteredName: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedOption: Int = 0
    @State private var shouldCommit: Bool = false
    @FocusState private var showKeyboard: Bool
    @State private var showAutocomplete = false
    @EnvironmentObject var dataFreezerItems: DataFreezerItems
    @EnvironmentObject var dataFridgeItems: DataFridgeItems
    @EnvironmentObject var dataPantryItems: DataPantryItems
    func generateExpirationDays(foodName: String, foodStorage: String) -> Int {
        do {
            let model = try foodExpirationDate_Model_v4(configuration: MLModelConfiguration())
            let inputFeatures = foodExpirationDate_Model_v4Input(Food_Name: foodName, Storage: foodStorage)
            let prediction = try model.prediction(input: inputFeatures)
            return Int(prediction.Days)
        } catch {
            return 0
        }
    }
    func autocompleteSuggestions() -> [String] {
        // Ensure that the enteredName is lowercased only once for efficiency
        let lowercasedEnteredName = enteredName.lowercased()
        
        // Use a set to store unique suggestions and improve performance
        var uniqueSuggestions = Set<String>()
        
        // Get all autocomplete terms
        let allSuggestions = autoCompleteTermsClass.getAutoCompleteTerms()
        
        for term in allSuggestions {
            // Check if the term contains the entered name (case-insensitive)
            if term.lowercased().contains(lowercasedEnteredName) {
                uniqueSuggestions.insert(term)
                
                // Break if we reach the desired number of suggestions
                if uniqueSuggestions.count >= 3 {
                    break
                }
            }
        }
        
        // Convert the set back to an array and return it
        let limitedSuggestions = Array(uniqueSuggestions)
        return limitedSuggestions
    }
    func scheduleNotificationsFridge(item: FridgeItem) {
          let center = UNUserNotificationCenter.current()
          let content = UNMutableNotificationContent()
          content.title = "Fridge Item Expiring"
          content.body = "\(item.itemName) is expiring soon!"
          content.sound = UNNotificationSound.default

          // Calculate the notification date based on the item's days and dateAdded
          let calendar = Calendar.current
          let expirationDate = calendar.date(byAdding: .day, value: item.days, to: item.dateAdded)!
        guard let notificationDate = calendar.date(byAdding: .day, value: -1, to: expirationDate) else {
            // Handle the error condition here, such as logging an error or returning a default value.
            return
        }


          let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)

          let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
          let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)

          center.add(request) { error in
              if let error = error {
                  print("Error scheduling notification: \(error)")
              } else {
                  print("Notification scheduled for \(item.itemName)")
              }
          }
      }
    func scheduleNotificationsFreezer(item: FreezerItem) {
          let center = UNUserNotificationCenter.current()
          let content = UNMutableNotificationContent()
          content.title = "Freezer Item Expiring"
          content.body = "\(item.itemName) is expiring soon!"
          content.sound = UNNotificationSound.default

          // Calculate the notification date based on the item's days and dateAdded
          let calendar = Calendar.current
          let expirationDate = calendar.date(byAdding: .day, value: item.days, to: item.dateAdded)!
        guard let notificationDate = calendar.date(byAdding: .day, value: -1, to: expirationDate) else {
            // Handle the error condition here, such as logging an error or returning a default value.
            return
        }


          let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)

          let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
          let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)

          center.add(request) { error in
              if let error = error {
                  print("Error scheduling notification: \(error)")
              } else {
                  print("Notification scheduled for \(item.itemName)")
              }
          }
      }
    func scheduleNotificationsPantry(item: PantryItem) {
          let center = UNUserNotificationCenter.current()
          let content = UNMutableNotificationContent()
          content.title = "Pantry Item Expiring"
          content.body = "\(item.itemName) is expiring soon!"
          content.sound = UNNotificationSound.default

          // Calculate the notification date based on the item's days and dateAdded
          let calendar = Calendar.current
          let expirationDate = calendar.date(byAdding: .day, value: item.days, to: item.dateAdded)!
        guard let notificationDate = calendar.date(byAdding: .day, value: -1, to: expirationDate) else {
            // Handle the error condition here, such as logging an error or returning a default value.
            return
        }


          let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)

          let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
          let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)

          center.add(request) { error in
              if let error = error {
                  print("Error scheduling notification: \(error)")
              } else {
                  print("Notification scheduled for \(item.itemName)")
              }
          }
      }
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    var body: some View {
        
        NavigationView {
            ZStack{
                VStack {
                    Form {
                        TextField("Enter Name", text: $enteredName)
                            .autocorrectionDisabled()
                            .focused($showKeyboard)
                            .keyboardType(.default)
                            .onTapGesture {showAutocomplete = true}
                        
                            .padding()
                        
                        
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            .padding()
                        
                        Picker("Where is the item stored?", selection: $selectedOption) {
                            Text("Freezer").tag(0)
                            Text("Fridge").tag(1)
                            Text("Pantry").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                    .scrollDisabled(true)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard){
                            if showAutocomplete {
                                   Picker("", selection: $enteredName) {
                                       ForEach(autocompleteSuggestions(), id: \.self) { term in
                                           Button(term){
                                            showAutocomplete = false
                                               enteredName = term
                                           }
                                       }
                                   }
                                   .pickerStyle(SegmentedPickerStyle())
                                   .frame(maxWidth: .infinity)
                               }
                            Button{
                                showKeyboard = false
                            } label:{
                                Image(systemName: "keyboard.chevron.compact.down.fill")
                            }
                        }
                        
                        
                    }
                }
                    .navigationBarTitle("Add Item")
                    .navigationBarTitleDisplayMode(.inline)
                    Button(action: {
                        requestNotificationAuthorization()

                        shouldCommit = true
                        if shouldCommit {
                            self.presentationMode.wrappedValue.dismiss()
                            switch selectedOption {
                            case 0:
                                let freezerItem = FreezerItem(emoji: generateEmoji(foodName: enteredName), itemName: enteredName, dateAdded: selectedDate, days: generateExpirationDays(foodName: enteredName.lowercased(), foodStorage: "Freezer"))

                                dataFreezerItems.addItem(item: freezerItem)
                                scheduleNotificationsFreezer(item: freezerItem)
                                
                            case 1:
                               let fridgeItem =  FridgeItem(emoji:  generateEmoji(foodName:enteredName), itemName: enteredName, dateAdded: selectedDate, days: generateExpirationDays(foodName: enteredName.lowercased(), foodStorage: "Refrigerator"))
                                
                                dataFridgeItems.addItem(item: fridgeItem)
                                scheduleNotificationsFridge(item: fridgeItem)
                                
                            case 2:
                               let pantryItem = PantryItem(emoji:  generateEmoji(foodName:enteredName), itemName: enteredName, dateAdded: selectedDate, days: generateExpirationDays(foodName: enteredName.lowercased(), foodStorage: "Pantry"))
                                
                                dataPantryItems.addItem(item: pantryItem)
                                scheduleNotificationsPantry(item: pantryItem)
                            default:
                                print("default")
                            }
                            shouldCommit = false
                        }
                    }) {
                        Text("Add item")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .scaleEffect(shouldCommit ? 1.1 : 1.0)
                    }
                    .offset(CGSize(width: 10.0, height: 10.0))
                }
            }
       
        }
    
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(DataFreezerItems())
                .environmentObject(DataFridgeItems())
                .environmentObject(DataPantryItems())
        }
    }

