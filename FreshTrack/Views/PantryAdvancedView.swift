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
    
    var daysLeft: Int {
            
            let components = calendar.dateComponents([.day], from: currentDate, to: item.dateAdded)
            
            let daysFromAddedToCurrent = components.day ?? 0
            return daysFromAddedToCurrent + item.days
        }
    
    var body: some View {
        VStack {
            CountdownTimerView(totalDays: item.days, daysLeft:daysLeft, customText: item.emoji)
                .padding()
            Text("Location: Pantry")
                .font(.headline)
            Text("Date added: \(calculateExpirationDate(daysRemaining: item.days) ?? "0")")
                .font(.headline)        }
        .navigationTitle(item.itemName)
        
        }
    }




#Preview {
    PantryAdvancedView(item: PantryItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 1))
}
