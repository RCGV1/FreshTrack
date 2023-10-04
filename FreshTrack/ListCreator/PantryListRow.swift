//
//  PantryListRow.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/3/23.
//

import SwiftUI

struct PantryListRow: View {
    let currentDate = Date()
    let calendar = Calendar.current
    var item:PantryItem

    
    var daysLeft: Int {
            
            let components = calendar.dateComponents([.day], from: currentDate, to: item.dateAdded)
            
            let daysFromAddedToCurrent = components.day ?? 0
            return daysFromAddedToCurrent + item.days
        }
    
    var body: some View {
        HStack{
           
            Text(item.emoji)
                .font(.system(size: 36))
            VStack{
           
                Text(item.itemName)
                    .bold()
                Text("Days Left: "+String(daysLeft))
                    .foregroundColor(daysLeft < 7 ? Color.red : Color.accentColor)
                    .font(Font.footnote)
                    .multilineTextAlignment(.leading)
            }
            
        }
    }
}

struct PantryListRow_Previews: PreviewProvider {
    static var previews: some View {

        PantryListRow(item: PantryItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 20))
    }
}
