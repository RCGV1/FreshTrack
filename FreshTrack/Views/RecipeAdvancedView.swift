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
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200) } else {
                                image
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                        }
                case .failure:
                    Text("Failed to load image")
                @unknown default:
                    Text("Unknown state")
                }
            }
        )
    case .failure(let error):
        return AnyView(
            Text("Failed to get image URL: \(error.localizedDescription)")
        )
    }
}

struct RecipeAdvancedView: View {

    var recipe: Recipe
        var body: some View {
            VStack {
                Text("Ingredients:")
                    .font(.headline)
                    .padding(.bottom, 5)
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("- \(ingredient)")
                        .padding(.leading, 20)
                }
                let resultOfImageSearch = getImageURL(for: recipe.title)
                displayImage(from: resultOfImageSearch, isAdvanced: true)

                Text("Instructions:")
                    .font(.headline)
                    .padding(.bottom, 5)
                Text(recipe.instructions)
                    .padding()

                Spacer()
            }
            .navigationTitle(recipe.title)
        }
}

#Preview {
    RecipeAdvancedView(recipe: Recipe(id: 1, title: "pizza", ingredients: ["Ingredient 1", "Ingredient 2"], instructions: "Sample instructions"))
}
