import CoreML
import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var enteredName: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedOption: Int = 0
    @State private var shouldCommit: Bool = false
    @EnvironmentObject var dataFreezerItems: DataFreezerItems
    @EnvironmentObject var dataFridgeItems: DataFridgeItems
    @EnvironmentObject var dataPantryItems: DataPantryItems
    func generateEmoji(foodName: String) -> String {
        do {
            let model = try nameToEmojiModel(configuration: MLModelConfiguration())
            let inputFeatures = nameToEmojiModelInput(Food_Name: foodName)
            let prediction = try model.prediction(input: inputFeatures)
            return prediction.Emoji
        } catch {
            return "🍽"
        }
    }
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
    var body: some View {
        NavigationView {
            VStack {
                List {
                    TextField("Enter Name", text: $enteredName)
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

                Button(action: {
                    shouldCommit = true
                    if shouldCommit {
                        switch selectedOption {
                        case 0:
                            dataFreezerItems.addItem(item: FreezerItem(emoji: generateEmoji(foodName:enteredName), itemName: enteredName, dateAdded: selectedDate, days: generateExpirationDays(foodName: enteredName, foodStorage: "Freezer")))

                        case 1:
                            dataFridgeItems.addItem(item: FridgeItem(emoji: "🍽", itemName: enteredName, dateAdded: selectedDate, days: generateExpirationDays(foodName: enteredName, foodStorage: "Fridge")))

                        case 2:
                            dataPantryItems.addItem(item: PantryItem(emoji: "🍽", itemName: enteredName, dateAdded: selectedDate, days: generateExpirationDays(foodName: enteredName, foodStorage: "Pantry")))
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
                Spacer()
                .padding()
            }
            .navigationBarTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
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
