//
//  IconView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/16.
//

import SwiftUI

struct IconView: View {
    var body: some View {
        ZStack {
            Image(systemName: "magazine")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.gray)
                .frame(width: 300, height: 300, alignment: .center)
            Image(systemName: "lock.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.yellow)
                .padding(.vertical, 12.0)
                .frame(width: 100.0, height: 100.0)
                .position(x: 160, y: 360)
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
