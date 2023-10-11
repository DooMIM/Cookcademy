//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by doha moustafa on 30/08/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    @State private var isPresenting = false
    
    var body: some View {
        VStack {
            HStack {
                RecipeDetailTextView(receipeText: "Author: \(recipe.mainInformation.author)")
                Spacer()
            }
            HStack {
                RecipeDetailTextView(receipeText: recipe.mainInformation.description)
                Spacer()
            }
            List {
                Section("Ingredients") {
                    ForEach(recipe.ingredients.indices, id: \.self) {
                        index in let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                }
                .listRowBackground(listBackgroundColor)
                
                Section("Directions") {
                    ForEach(recipe.directions.indices, id: \.self) {
                        index in let direction = recipe.directions[index]
                        HStack {
                            Text("\(index + 1). ").bold()
                            Text("\(direction.isOptional ? "(Optional) " : "")"
                                 + "\(direction.description)")
                        }
                        .foregroundColor(listTextColor)
                        
                    }
                }
                .listRowBackground(listBackgroundColor)
            }
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar {
            ToolbarItem {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    Button(action: {
                                recipe.isFavorite.toggle()
                              }) {
                                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                              }
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                            }
                        }
                    }
                    .navigationTitle("Edit Recipe")
            }
        }
    }
}


// added a static recipe property, for the canvas to render.

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe: Recipe = Recipe.testRecipes[1]
    static var previews: some View {
        NavigationStack {
            RecipeDetailView(recipe: $recipe)
        }
    }
}
