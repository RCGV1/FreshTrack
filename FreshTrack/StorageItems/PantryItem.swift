//
//  PantryItem.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/3/23.
//

import Foundation

struct PantryItem: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var emoji: String
    var itemName: String
    var dateAdded: Date
    var days: Int
    
    
}
