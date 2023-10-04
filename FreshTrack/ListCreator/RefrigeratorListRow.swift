//
//  RefrigeratorListRow.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/2/23.
//

import SwiftUI

struct RefrigeratorListRow: View {
    var item:RefrigeratorItem
    var body: some View {
        HStack{
           
            Text(item.emoji)
                .font(.system(size: 36))
            VStack{
           
                Text(item.itemName)
                    .bold()
                Text("Days Left: "+String(item.days))
                    .foregroundColor(item.days < 7 ? Color.red : Color.accentColor)
                    .font(Font.footnote)
                    .multilineTextAlignment(.leading)
            }
            
        }
    }
}

struct RefrigeratorListRow_Previews: PreviewProvider {
    static var previews: some View {
        RefrigeratorListRow(item: RefrigeratorItem(emoji: "🍔",itemName: "Hamburger",  dateAdded: "9/5/2023", days: 20))
    }
}
