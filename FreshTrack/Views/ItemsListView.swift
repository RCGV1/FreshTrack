import SwiftUI

struct ItemsListView: View {
    @StateObject var dataRefrigeratorItems = DataRefrigeratorItems()
    @StateObject var dataFridgeItems = DataFridgeItems()
    @StateObject var dataPantryItems = DataPantryItems()

    var body: some View {
        VStack {
            Button("testing") { // Just testing can be removed
                dataPantryItems.addItem(item: PantryItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 20))
            }
            List {
                Section(header: Text("Refrigerator Items ❄️")) {
                    ForEach(dataRefrigeratorItems.items, id: \.self) { item in
                        RefrigeratorListRow(item: item)
                    }
                    .onDelete { indexSet in
                        dataRefrigeratorItems.deleteItem(indexSet: indexSet)
                    }
                }
                Section(header: Text("Fridge Items 🧊")) {
                    ForEach(dataFridgeItems.items, id: \.self) { item in
                        FridgeListRow(item: item)
                    }
                    .onDelete { indexSet in
                        dataFridgeItems.deleteItem(indexSet: indexSet)
                    }
                }
                
                Section(header: Text("Pantry Items 🗄️")) {
                    ForEach(dataPantryItems.items, id: \.self) { item in
                        PantryListRow(item: item)
                    }
                    .onDelete { indexSet in
                        dataPantryItems.deleteItem(indexSet: indexSet)
                    }
                }
            }
            .onAppear() {
                dataRefrigeratorItems.getRefrigeratorItems()
                dataFridgeItems.getFridgeItems()
            }
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView()
    }
}
