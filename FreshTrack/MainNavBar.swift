//
//  MainNavBar.swift
//  FreshTrack
//
//  Created by Benjamin Faershtein on 10/2/23.
//

import SwiftUI

struct MainNavBar: View {
    var body: some View {
        TabView{
            ItemsListView()
                .tabItem {
                    Image(systemName: "carrot.fill")
                    Text("Saved Foods")
                }
            Text("Test")
                .tabItem {
                    Image(systemName: "carrot")
                    Text("Test")
                }
            
        }
    
    }
}

struct MainNavBar_Previews: PreviewProvider {
    static var previews: some View {
        MainNavBar()
    }
}
