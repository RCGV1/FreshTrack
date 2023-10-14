import SwiftUI

struct ItemsListView: View {
    
    @EnvironmentObject var dataFreezerItems : DataFreezerItems
    @EnvironmentObject var dataFridgeItems : DataFridgeItems
    @EnvironmentObject var dataPantryItems : DataPantryItems
    
    
        var body: some View {
            
            NavigationView {
                VStack {
                    HStack {
                        Text("Your Items")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink(destination:ContentView()) {
                            Image(systemName: "plus")
                                    .font(.title)
                                    .cornerRadius(10)
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        
                    }
                    .padding()
                    if (dataFridgeItems.items.isEmpty && dataPantryItems.items.isEmpty && dataFreezerItems.items.isEmpty){
                        Spacer()
                        Text("There are no items here yet")
                        Text("Add an item using the + button")
                        Spacer()
                    } else {
                        List {
                            Section(header: Text("Freezer Items ❄️").fontWeight(.bold).font(.headline)) {
                                ForEach(dataFreezerItems.items.sorted(by: { $0.days < $1.days }), id: \.self) { item in
                                    NavigationLink(destination: FreezerAdvancedView(item: item)) {
                                        FreezerListRow(item: item)
                                    }
                                }
                                .onDelete { indexSet in
                                    dataFreezerItems.deleteItem(indexSet: indexSet)
                                }
                            }
                            
                            
                            Section(header: Text("Fridge Items 🧊").fontWeight(.bold).font(.headline)) {
                                ForEach(dataFridgeItems.items.sorted(by: { $0.days < $1.days }), id: \.self) { item in
                                    NavigationLink(destination: FridgeAdvancedView(item: item)) {
                                        FridgeListRow(item: item)
                                    }
                                }
                                .onDelete { indexSet in
                                    dataFridgeItems.deleteItem(indexSet: indexSet)
                                }
                                
                            }
                            
                            
                            
                            Section(header: Text("Pantry Items 🗄️").fontWeight(.bold).font(.headline)) {
                                ForEach(dataPantryItems.items.sorted(by: { $0.days < $1.days }), id: \.self) { item in
                                    NavigationLink(destination: PantryAdvancedView(item: item)) {
                                        PantryListRow(item: item)
                                    }
                                }
                                .onDelete { indexSet in
                                    dataPantryItems.deleteItem(indexSet: indexSet)
                                }
                            }
                            
                        }
                    }

                    
                }
                
            }
            .onAppear() {
                dataFreezerItems.getFreezerItems()
                dataFridgeItems.getFridgeItems()
                dataPantryItems.getPantryItems()
            }
        }
    }
    
    struct ItemsListView_Previews: PreviewProvider {
        static var previews: some View {
            ItemsListView()
                .environmentObject(DataFreezerItems())
                .environmentObject(DataFridgeItems())
                .environmentObject(DataPantryItems())

        }
    }
    
