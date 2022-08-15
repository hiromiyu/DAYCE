//
//  KeyView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/11.
//

import SwiftUI

struct KeyView: View {
    var body: some View {
        ZStack {
        Circle()
            .foregroundColor(.yellow)
            .frame(width: 80, height: 80)
            .position(x: 150, y: 260)
        Circle()
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .position(x: 150, y: 260)
        Rectangle()
            .foregroundColor(.yellow)
            .frame(width: 30, height: 130)
            .position(x: 150, y: 360)
        Rectangle()
            .foregroundColor(.yellow)
            .frame(width: 50, height: 30)
            .position(x: 180, y: 330)
        Rectangle()
            .foregroundColor(.yellow)
            .frame(width: 50, height: 30)
            .position(x: 180, y: 380)
        }
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView()
    }
}
