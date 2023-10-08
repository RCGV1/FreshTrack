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
    var body: some View {
        VStack {
            CountdownTimerView(totalDays: 30, daysLeft:item.days, customText: item.emoji)
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
