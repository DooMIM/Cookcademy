//
//  ContentView.swift
//  Cookcademy
//
//  Created by doha moustafa on 30/08/2023.
//

import SwiftUI

struct RecipesListView: View {
    // Since RecipesListView will be a child view, RecipesListView will access that data through the environment using the @EnvironmentObject property wrapper.
    @EnvironmentObject private var recipeData: RecipeData
    //ViewStyle enum in the extension contains the different categories as well as favorites filter
    let viewStyle: ViewStyle
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        /* To create a list of recipes, we need the following:
         Create a view model that connects the model to the view.
         Create a reference to the view model in the view
         Update the view when the view model changes
         */
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe)))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle(navigationTitle)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    newRecipe = Recipe()
                    newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        })
        .sheet(isPresented: $isPresenting, content: {
            NavigationView {
                ModifyRecipeView(recipe: $newRecipe)
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            if newRecipe.isValid {
                                Button("Add") {
                                    // we created a func called add in the viewmodel, so that we dont talk directly to the model.
                                    recipeData.add(recipe: newRecipe)
                                    isPresenting = false
                                }
                            }
                        }
                    })
                    .navigationTitle("Add a New Recipe")
            }
        })
    }
}

extension RecipesListView {
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    private var recipes: [Recipe] {
        switch viewStyle {
        case let .singleCategory(category):
            return recipeData.recipes(for: category)
        case .favorites:
            return recipeData.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(category):
            return "\(category.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
    }
    // write a function that returns a binding recipe, using the index function that we wrote in RecipeDate viewModel
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(viewStyle: .singleCategory(.breakfast))
        }.environmentObject(RecipeData())
    }
}
