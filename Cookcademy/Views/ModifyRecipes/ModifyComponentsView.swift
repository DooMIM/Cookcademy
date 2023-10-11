//
//  ModifyIngredientsView.swift
//  Cookcademy
//
//  Created by doha moustafa on 05/09/2023.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
    static func singularName() -> String
    static func pluralName() -> String
    init()
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping(Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView> : View where DestinationView.Component == Component {
    @Binding var components: [Component]
    
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }.navigationTitle("Add \(Component.singularName().capitalized)")
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: addComponentView)
                Spacer()
            } else {
                HStack {
                     Text(Component.pluralName().capitalized)
                       .font(.title)
                       .padding()
                     Spacer()
                   }
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        let editComponentView = DestinationView(component: $components[index]) { _ in return }
                            .navigationTitle("Edit \(Component.singularName().capitalized)")
                        NavigationLink(component.description, destination: editComponentView)
                    }
                    .onDelete { components.remove(atOffsets: $0)}
                    .onMove { indices, newOffset in  components.move(fromOffsets: indices, toOffset: newOffset)}
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another \(Component.singularName())",
                                   destination: addComponentView)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(listBackgroundColor)
                }.foregroundColor(listTextColor)
            }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    @State static var emptyIngredients = [Ingredient]()
    static var previews: some View {
        NavigationStack {
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
        }
    }
}

