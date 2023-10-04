//
//  DataRefrigeratorItems.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/2/23.
//

import Foundation

class DataRefrigeratorItems: ObservableObject {
    @Published var items: [RefrigeratorItem] = []{
        didSet{
            saveItems()
        }
    }
    func getRefrigerator(){
        guard let data = UserDefaults.standard.data(forKey: "Refrigerator_Items") else { return }
        guard let savedItems = try? JSONDecoder().decode([RefrigeratorItem].self, from: data) else { return }
        self.items = savedItems
    }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: "Refrigerator_Items")
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
        
        func addItem(item: RefrigeratorItem){
            items.append(item)
            saveItems()
        }
    
    }


