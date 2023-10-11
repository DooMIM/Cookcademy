//
//  RefactoredText.swift
//  Cookcademy
//
//  Created by doha moustafa on 30/08/2023.
//

import SwiftUI

struct RecipeDetailTextView: View {
    var receipeText: String
    var body: some View {
        VStack {
           Text(receipeText)
                .font(.subheadline)
                .padding()
        }
    }
}

struct RecipeDetailTextView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailTextView(receipeText: "Text")
    }
}
