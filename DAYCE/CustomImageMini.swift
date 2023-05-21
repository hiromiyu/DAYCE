//
//  CustomImageMini.swift
//  DAYCE
//
//  Created by ひろ on 2023/04/30.
//

import SwiftUI

struct CustomImageMini: View {
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 70, height: 70)
            }
            .shadow(radius: 10)
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .frame(width: 60, height: 50)
                .foregroundColor(.black)
                .opacity(0.5)
        }
    }
}

struct CustomImageMini_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageMini()
    }
}
