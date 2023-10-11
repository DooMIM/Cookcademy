//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by doha moustafa on 05/09/2023.
//

import SwiftUI

struct ModifyMainInformationView: View {
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        Form {
            Section {
                TextField("Recipe Name", text:$mainInformation.name)
                    .listRowBackground(listBackgroundColor)

                TextField("Author", text:$mainInformation.author)
                    .listRowBackground(listBackgroundColor)

            }
            Section("Description") {
                TextField("", text:$mainInformation.description)
                    .listRowBackground(listBackgroundColor)
                
            }
            Picker("Category", selection: $mainInformation.category) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var mainInformation = MainInformation(name: "na",
                                                        description: "des",
                                                        author: "aut",
                                                        category: .breakfast)
    @State static var emptyInformation = MainInformation(name: "",
                                                        description: "",
                                                        author: "",
                                                        category: .breakfast)
    static var previews: some View {
        ModifyMainInformationView(mainInformation: $mainInformation)
        ModifyMainInformationView(mainInformation: $emptyInformation)
    }
}
