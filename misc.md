//
//  FreezerItemDetails.swift
//  FreshTrack
//
//  Created by Neel Vinchhi on 07/10/23.
//


import SwiftUI

struct FreezerItemDetails: View {
    let currentDate = Date()
    let calendar = Calendar.current
    var item: FreezerItem
    var body: some View {
        VStack {
            CountdownTimerView(totalDays: 30, daysLeft:item.days, customText: item.emoji)
                .padding()
            Text("Location: Freezer")
                .font(.headline)
            Text(calculateExpirationDate(numberOfDays: item.days))
        }
        .navigationTitle(item.itemName)
        
        }
    }




#Preview {
    FreezerItemDetails(item: FreezerItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 1))
}
