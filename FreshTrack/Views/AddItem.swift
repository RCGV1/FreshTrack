import SwiftUI


struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var enteredName: String = ""
    @State private var selectedDate = Date()
    @State private var selectedOption = 0
    @State private var shouldCommit: Bool = false
    @EnvironmentObject var dataFreezerItems : DataFreezerItems
    @EnvironmentObject var dataFridgeItems : DataFridgeItems
    @EnvironmentObject var dataPantryItems : DataPantryItems


    var body: some View {
        
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
                }
                .pickerStyle(InlinePickerStyle())
                .padding()
                
                                
            }
            .navigationBarTitle("Add Item")

                Button(action: {
                    shouldCommit = true
                    if shouldCommit {
                        switch selectedOption {
                        case 0:
                            dataFreezerItems.addItem(item: FreezerItem(emoji: "🍽", itemName: enteredName, dateAdded: selectedDate, days: 30))
                        case 1:
                            dataFridgeItems.addItem(item: FridgeItem(emoji: "🍽", itemName: enteredName, dateAdded: selectedDate, days: 30))

                        case 2:
                            dataPantryItems.addItem(item: PantryItem(emoji: "🍽", itemName: enteredName, dateAdded: selectedDate, days: 30))
                        default:
                            print("default")
                        }
                        shouldCommit = false
                    }
                }) {
                    Text("Add item")
                        .foregroundColor(.white)
                        .padding()
                        .background(shouldCommit ? Color.accentColor : Color.accentColor)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .scaleEffect(shouldCommit ? 1.1 : 1.0)
                }

                    }
                }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

