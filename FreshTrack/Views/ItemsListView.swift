import SwiftUI
import Foundation


struct ItemsListView: View {
    
    @StateObject var dataFreezerItems = DataFreezerItems()
    @StateObject var dataFridgeItems = DataFridgeItems()
    @StateObject var dataPantryItems = DataPantryItems()
    //@Binding var enteredName: String
    let contentView = ContentView(onAddItem: {})
    
    func addItemToList() {
        dataFridgeItems.addItem(item: FridgeItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 20))
        print(contentView.enteredName)
    }

        var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        Text("Your Items")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(destination:ContentView(onAddItem: addItemToList)) {
                            Image(systemName: "plus")
                                .font(.title)
                            
                                .cornerRadius(10)
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        
                    }
                    .padding()
                    List {
                        Section(header: Text("Freezer Items ❄️").fontWeight(.bold).font(.headline)) {
                            ForEach(dataFreezerItems.items, id: \.self) { item in
                                FreezerListRow(item: item)
                            }
                            .onDelete { indexSet in
                                dataFreezerItems.deleteItem(indexSet: indexSet)
                            }
                        }
                        Section(header: Text("Fridge Items 🧊").fontWeight(.bold).font(.headline)) {
                            ForEach(dataFridgeItems.items, id: \.self) { item in
                                FridgeListRow(item: item)
                            }
                            .onDelete { indexSet in
                                dataFridgeItems.deleteItem(indexSet: indexSet)
                            }
                        }
                        
                        Section(header: Text("Pantry Items 🗄️").fontWeight(.bold).font(.headline)) {
                            ForEach(dataPantryItems.items, id: \.self) { item in
                                PantryListRow(item: item)
                               
                            }
                            .onDelete { indexSet in
                                dataPantryItems.deleteItem(indexSet: indexSet)
                            }
                        }
                    }
                    .onAppear() {
                        dataFreezerItems.getFreezerItems()
                        dataFridgeItems.getFridgeItems()
                    }
                }
            }
        }
    }
    
    struct ItemsListView_Previews: PreviewProvider {
        //@State static var enteredName: String = ""
        static var previews: some View {
            ItemsListView()
        }
    }
    

