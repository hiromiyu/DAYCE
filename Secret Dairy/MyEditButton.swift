//
//  MyEditButton.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/23.
//

import SwiftUI

struct MyEditButton: View {
    @Environment(\.editMode) var editmode
    
    
    var body: some View {
        Button(action: {
            withAnimation() {
            if editmode?.wrappedValue.isEditing == true {
                editmode?.wrappedValue = .inactive
            } else {
                editmode?.wrappedValue = .active
                }
            }
        }) {
            if editmode?.wrappedValue.isEditing == true {
                Text("終了")
            } else {
                Text("編集")
            }
        }
    }
}

struct MyEditButton_Previews: PreviewProvider {
    static var previews: some View {
        MyEditButton()
    }
}
