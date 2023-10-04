//
//  DataPantryItem.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/3/23.
//

import Foundation

class DataPantryItems: ObservableObject {
    @Published var items: [PantryItem] = []{
        didSet{
            saveItems()
        }
    }
    func getPantryItems(){
        guard let data = UserDefaults.standard.data(forKey: "Pantry_Items") else { return }
        guard let savedItems = try? JSONDecoder().decode([PantryItem].self, from: data) else { return }
        self.items = savedItems
    }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: "Pantry_Items")
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
        
        func addItem(item: PantryItem){
            items.append(item)
            saveItems()
        }
    
    }
