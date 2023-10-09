//
//  FreezerItemDetails.swift
//  FreshTrack
//
//  Created by Neel Vinchhi on 07/10/23.
//


import SwiftUI

struct FreezerAdvancedView: View {
    let currentDate = Date()
    let calendar = Calendar.current
    var item: FreezerItem
    var daysLeft: Int {
            
            let components = calendar.dateComponents([.day], from: currentDate, to: item.dateAdded)
            
            let daysFromAddedToCurrent = components.day ?? 0
            return daysFromAddedToCurrent + item.days
        }
    
    var body: some View {
        VStack {
            Text(item.itemName)
                .font(.largeTitle)
            CountdownTimerView(totalDays: item.days, daysLeft:daysLeft, customText: item.emoji)
                .padding()
            Text("Location: Freezer")
                .font(.headline)
            Text(calculateExpirationDate(daysRemaining: item.days) ?? "0")
        }
        .navigationTitle(item.itemName)
        
        }
    }




#Preview {
    FreezerAdvancedView(item: FreezerItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 1))
}
