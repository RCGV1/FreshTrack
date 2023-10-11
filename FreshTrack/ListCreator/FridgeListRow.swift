//
//  FridgeListRow.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/3/23.
//

import SwiftUI

struct FridgeListRow: View {
    let currentDate = Date()
    let calendar = Calendar.current
    var item:FridgeItem

    
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
                switch daysLeft {
                    case let x where x < 1:
                        Text("Item Expired!")
                            .font(Font.footnote)
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.leading)
                    default:
                        Text("Days Left: "+String(daysLeft))
                            .foregroundColor(daysLeft < 7 ? Color.yellow : Color.accentColor)
                            .font(Font.footnote)
                            .multilineTextAlignment(.leading)
                }

            }
            
        }
    }
}

struct FridgeListRow_preview: PreviewProvider {
    static var previews: some View {

        FridgeListRow(item: FridgeItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: Date(), days: 20))
    }
}

