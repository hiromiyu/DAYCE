//
//  IconView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/16.
//

import SwiftUI

struct IconView: View {
    var body: some View {
        VStack {
            ZStack() {
                Rectangle()
                    .foregroundColor(.purple)
                //                .rotationEffect(.degrees(45))
                //                .position(x: 300 ,y: 550)
                ZStack() {
                    Image(systemName: "magazine")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 270, alignment: .center)
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 12.0)
                        .frame(width: 100.0, height: 100.0)
                        .position(x: 178, y: 410)
                }
                Text("DAYCE")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .scaleEffect(2)
                    .position(x: 200, y: 600)
            }
            
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
