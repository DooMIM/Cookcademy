//
//  MainTabView.swift
//  Cookcademy
//
//  Created by doha moustafa on 12/09/2023.
//

import SwiftUI

struct MainTabView: View {
    /* MainTabView will be the initial view the user sees, it should create and own the view model. Thats why in recipeCategoryGridView, the recipeData will be passed in as an enviromentObject instead of creating its own. */
    
    @StateObject var recipeData = RecipeData()
    var body: some View {
        TabView {
            RecipeCategoryGridView()
                .tabItem { Label("Recipes", systemImage: "list.dash")}
            // RecipeListView is embedded in a NavigationView so that the toolbar will display correctly at the top and it can present the recipe detail view.
            NavigationView {
                RecipesListView(viewStyle: .favorites)
            }.tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .environmentObject(recipeData)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
