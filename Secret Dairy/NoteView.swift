//
//  NoteView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/11.
//

import SwiftUI

struct NoteView: View {
    var body: some View {
        ZStack {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: 250, height: 350)
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 200, height: 300)
                .foregroundColor(.white)
            Rectangle()
                .frame(width: 30, height: 300)
                .position(x: 230, y: 323.3)
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 70, height: 30)
                .position(x: 75, y: 230)
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 70, height: 30)
                .position(x: 75, y: 290)
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 70, height: 30)
                .position(x: 75, y: 350)
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 70, height: 30)
                .position(x: 75, y: 410)
            KeyView()
        }
        .background(.gray)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
