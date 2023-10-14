//
//  RecipeView.swift
//  FreshTrack
//
//  Created by Neel Vinchhi on 09/10/23.
//

import SwiftUI
import URLImage

struct Recipe: Identifiable, Decodable {
    var id: Int
    var title: String
    var ingredients: [String]
    var instructions: String
}

func parseRecipes(from jsonString: String) -> [Recipe]? {
    let data = Data(jsonString.utf8)
    let decoder = JSONDecoder()
    
    do {
        let recipes = try decoder.decode([Recipe].self, from: data)
        return recipes
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}



struct RecipeView: View {
    @EnvironmentObject var dataFreezerItems: DataFreezerItems
    @EnvironmentObject var dataFridgeItems: DataFridgeItems
    @EnvironmentObject var dataPantryItems: DataPantryItems
    @State private var generatedText = ""
    let openAIService = OpenAIService()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                
                    
                }
                .padding()
                
                List(parseRecipes(from: generatedText) ?? []) { recipe in
                    NavigationLink(destination: RecipeAdvancedView(recipe: recipe)) {
                        HStack{
                            let resultOfImageSearch1 = getImageURL(for: recipe.title)
                            displayImage(from: resultOfImageSearch1, isAdvanced: false)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            Text(recipe.title)
                        }
                    }
                }
                if (dataFridgeItems.items.isEmpty && dataPantryItems.items.isEmpty && dataFreezerItems.items.isEmpty){
                    Text("There are no items yet")
                        .offset(y: -500)
                } else {
                    Button(action: {
                        let ingredients = "\(dataFreezerItems.items) \(dataFridgeItems.items) \(dataPantryItems.items)"
                        openAIService.sendRequest(message: """
                        Generate 2 easy to make recipes made of the following ingredients: \(ingredients). Please generate a single JSON object with the following structure: {"id": integer starting from 1 depending on the recipe number, "title": "title of the recipe", "ingredients": [ingredient 1, ingredient 2, ingredient 3,etc], "instructions":"instructions on the recipe"}. Wrap all of the recipes in an array to make it a single JSON object.
                    """) { text in
                            generatedText = text
                        }
                    }) {
                        HStack{
                            Text("Generate Recipes")
                            Image(systemName: "fork.knife")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .offset(y: -50)
                    
                    
                }
            }
            }
        }
    }


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
            .environmentObject(DataFreezerItems())
            .environmentObject(DataFridgeItems())
            .environmentObject(DataPantryItems())
    }
}

