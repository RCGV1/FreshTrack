//
//  DataFreezerItems.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/2/23.
//

import Foundation

class DataFreezerItems: ObservableObject {
    @Published var items: [FreezerItem] = []{
        didSet{
            saveItems()
        }
    }
    func getFreezerItems(){
        guard let data = UserDefaults.standard.data(forKey: "Freezer_Items") else { return }
        guard let savedItems = try? JSONDecoder().decode([FreezerItem].self, from: data) else { return }
        self.items = savedItems
    }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: "Freezer_Items")
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
        
        func addItem(item: FreezerItem){
            items.append(item)
            saveItems()
        }
    
    }


