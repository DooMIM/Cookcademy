//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by doha moustafa on 07/09/2023.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    @Binding var direction : Direction
    let createAction: (Direction) -> Void
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    dismiss()
                }
                Spacer()
            }
            .listRowBackground(listBackgroundColor)
        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var emptyDirection = Direction(description: "", isOptional: false)
    static var previews: some View {
      
            ModifyDirectionView(component: $emptyDirection) {_ in return}
    }
}

