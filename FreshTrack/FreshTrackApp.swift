//
//  FreshTrackApp.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/2/23.
//

import SwiftUI

@main
struct FreshTrackApp: App {

    var body: some Scene {
        WindowGroup {
            MainNavBar(dataFreezerItems: DataFreezerItems(), dataFridgeItems: DataFridgeItems(), dataPantryItems: DataPantryItems())
        }
    
    }
}
