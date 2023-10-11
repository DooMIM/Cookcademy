//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by doha moustafa on 05/09/2023.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
/* We want to assign a value to the ingredient property marked with the @Binding property wrapper. We can do that by adding a leading underscore. self._ingredient is of type Binding<Ingredient> and can be assigned to the binding passed into the initializer.
        */
        self._ingredient = component
        self.createAction = createAction
    }
    
    
    @Binding var ingredient: Ingredient
    @Environment (\.dismiss) var dismiss
    @FocusState private var amountIsFocused : Bool
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    let createAction: ((Ingredient)-> Void)
    
    var body: some View {
      
        Form {
            TextField("Ingredient Name", text: $ingredient.name)
                .listRowBackground(listBackgroundColor)
            Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                HStack {
                    Text("Quantity:")
                    TextField("Quantity", value: $ingredient.quantity, formatter: NumberFormatter.decimal)
                        .keyboardType(.numbersAndPunctuation)
                }
            }.listRowBackground(listBackgroundColor)
            Picker(selection: $ingredient.unit, label: HStack {
                Text("Unit")
                Spacer()
                Text(ingredient.unit.rawValue)
            }) {
                ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                    Text(unit.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
            HStack {
                Spacer()
                Button("Save") {
                    createAction(ingredient)
                    dismiss()
                }
                Spacer()
            }.listRowBackground(listBackgroundColor)
        }
        .foregroundColor(listTextColor)
    }
}

/*the formatter needs the correct format for the application. In the stepper, the NumberFormatter needs a numberStyle of .decimal to indicate decimal-style numbers. Let’s extend NumberFormatter to return a new format with this specific style.*/

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var emptyIngredient = Ingredient()
    static var previews: some View {
        ModifyIngredientView(component: $emptyIngredient) { ingredient
            in
            print(ingredient)
        }
    }
}
