//
//  RecipeView.swift
//  FreshTrack
//
//  Created by Neel Vinchhi on 09/10/23.
//
import SwiftUI
import SwiftSyntax


struct RecipeView: View {
    @EnvironmentObject var dataFreezerItems: DataFreezerItems
    @EnvironmentObject var dataFridgeItems: DataFridgeItems
    @EnvironmentObject var dataPantryItems: DataPantryItems
    @State private var generatedText = ""
    let openAIService = OpenAIService()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(generatedText)
            }
            .onAppear {
                let ingredients = "\(dataFreezerItems.items) \(dataFridgeItems.items) \(dataPantryItems.items)"
                openAIService.sendRequest(message: "Generate an easy to make recipe made of the following ingredients: \(ingredients).") { text in
                    // Update the UI with the generated text
                    generatedText = text
                }
            }
        }
    }
}


//struct RecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeView()
//            .environmentObject(DataFreezerItems())
//            .environmentObject(DataFridgeItems())
//            .environmentObject(DataPantryItems())
//    }
//}

