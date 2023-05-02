//
//  CustomImage.swift
//  DAYCE
//
//  Created by ひろ on 2023/04/30.
//

import SwiftUI

struct CustomImage: View {
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 150)
            }
            .cornerRadius(20)
            .shadow(radius: 10)
            Image(systemName: "apple.logo")
                .resizable()
                .frame(width: 80, height: 100)
                .foregroundColor(.accentColor)
                .opacity(0.5)
        }
    }
}

struct CustomImage_Previews: PreviewProvider {
    static var previews: some View {
        CustomImage()
    }
}
