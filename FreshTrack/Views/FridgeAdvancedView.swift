//
//  FridgeItemDetails.swift
//  FreshTrack
//
//  Created by Neel Vinchhi on 07/10/23.
//


import SwiftUI

struct FridgeAdvancedView: View {
    let currentDate = Date()
    let calendar = Calendar.current
    var item: FridgeItem
    var body: some View {
        VStack {
            CountdownTimerView(totalDays: 30, daysLeft:item.days, customText: item.emoji)
                .padding()
            Text("Location: Fridge")
                .font(.headline)
            Text(calculateExpirationDate(daysRemaining: item.days) ?? "0")
        }
        .navigationTitle(item.itemName)
        
        }
    }




#Preview {
    FridgeAdvancedView(item: FridgeItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 1))
}
