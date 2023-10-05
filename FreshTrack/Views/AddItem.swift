import SwiftUI


struct ContentView: View {
    var onAddItem: () -> Void
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var enteredName: String = ""
    @State var selectedDate = Date()
    @State var selectedOption = 0
    let options = ["Freezer", "Fridge", "Pantry"]
    @State private var shouldCommit: Bool = false


    var body: some View {
        
        VStack {
            List {
                TextField("Enter Name", text: $enteredName)                .padding()
                
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                
                Picker("Where is the item stored?", selection: $selectedOption) {
                    ForEach(0..<options.count, id: \.self) {
                        Text(options[$0])
                    }
                }
                .pickerStyle(InlinePickerStyle())
                .padding()
                
                                
            }
            .navigationBarTitle("Add Item")

                Button(action: {
                    shouldCommit = true
                }) {
                    Text("Add item")
                        .foregroundColor(.white)
                        .padding()
                        .background(shouldCommit ? Color.accentColor : Color.accentColor)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .scaleEffect(shouldCommit ? 1.1 : 1.0)
                }
                .onChange(of: shouldCommit) { _ in
                    if shouldCommit {
                        onAddItem()
                        shouldCommit = false
                    }
                }


        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(onAddItem: {})
    }
}

