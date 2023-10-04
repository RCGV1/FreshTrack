//
//  DataFridgeItem.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/3/23.
//

import Foundation

class DataFridgeItems: ObservableObject {
    @Published var items: [FridgeItem] = []{
        didSet{
            saveItems()
        }
    }
    func getFridgeItems(){
        guard let data = UserDefaults.standard.data(forKey: "Fridge_Items") else { return }
        guard let savedItems = try? JSONDecoder().decode([FridgeItem].self, from: data) else { return }
        self.items = savedItems
    }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: "Fridge_Items")
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
        
        func addItem(item: FridgeItem){
            items.append(item)
            saveItems()
        }
    
    }
