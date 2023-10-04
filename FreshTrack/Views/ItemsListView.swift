import SwiftUI

struct ItemsListView: View {
    @StateObject var dataRefrigeratorItems = DataRefrigeratorItems()

    var body: some View {
        VStack {
            Button("testing") {
                dataRefrigeratorItems.addItem(item: RefrigeratorItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: "9/5/2023", days: 20))
            }
            List {
                Section(header: Text("Fridge Items 🧊")) {
                    ForEach(dataRefrigeratorItems.items, id: \.self) { item in
                        RefrigeratorListRow(item: item)
                    }
                    .onDelete { indexSet in
                        dataRefrigeratorItems.deleteItem(indexSet: indexSet)
                    }
                }
            }
            .onAppear() {
                dataRefrigeratorItems.getRefrigerator()
            }
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView()
    }
}
