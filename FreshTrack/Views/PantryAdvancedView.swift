//
//  FreshTrack
//
//  Created by Neel Vinchhi on 07/10/23.
//


import SwiftUI

struct PantryAdvancedView: View {
    let currentDate = Date()
    let calendar = Calendar.current
    var item: PantryItem
    var body: some View {
        VStack {
            CountdownTimerView(totalDays: 30, daysLeft:item.days, customText: item.emoji)
                .padding()
            Text("Location: Pantry")
                .font(.headline)
            Text(calculateExpirationDate(daysRemaining: item.days) ?? "0")
        }
        .navigationTitle(item.itemName)
        
        }
    }




#Preview {
    PantryAdvancedView(item: PantryItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 1))
}
