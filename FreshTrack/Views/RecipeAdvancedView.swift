//
//  RecipeAdvancedView.swift
//  FreshTrack
//
//  Created by Neel Vinchhi on 13/10/23.
//

import SwiftUI

func displayImage(from result: Result<String, ImageURLError>, isAdvanced: Bool) -> AnyView {
    switch result {
    case .success(let imageURL):
        return AnyView(
            AsyncImage(url: URL(string: imageURL)!) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Loading indicator while the image is loading
                case .success(let image):
                    if isAdvanced {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 1000, height: 300)
                            .brightness(-0.05)
                        
                    } else {
                                image
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                        }
                case .failure:
                    Text("")
                @unknown default:
                    Text("")
                }
            }
        )
    case .failure:
        return AnyView(
            Text("")
        )
    }
}

struct RecipeAdvancedView: View {

    var recipe: Recipe
        var body: some View {
            ScrollView {
                VStack {
                    let resultOfImageSearch = getImageURL(for: recipe.title)
                    displayImage(from: resultOfImageSearch, isAdvanced: true)
                    Spacer()
                    Text("Ingredients:")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("- \(ingredient)")
                            .padding(.leading, 20)
                    }
                    Text("Instructions:")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                    Text(recipe.instructions)
                        .font(.body)
                        .padding(10)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .navigationTitle(recipe.title)
            }
        }
}

#Preview {
    RecipeAdvancedView(recipe: Recipe(id: 1, title: "pizza", ingredients: ["Ingredient 1", "Ingredient 2"], instructions: "Sample instructionsdsfkjdbsfksjdbfskfjbsdfkjhdsbfjksdhbdfjkhbgdsjhkbdfgjhbsdfgkjhbsdfgjkhbsdgjkhbsdfgjhkbdsfgjkhdsbfgjhdsfbgjkshfbgdskjhbsdfjkhbdsfjkhbdfgjkhbfgjkhbdsgjhbsdfgjkhbsdfgjkhbsfdgjhsbdfgjksdhbgskdjfhgfydberugyfesbdjhbsdfkgjhsdbfgkjsdhfbgsdkfjghbsdfgksjdhfglsdfjhgbsdflgjbhjhfbdgljdhsfbgfd"))
}
