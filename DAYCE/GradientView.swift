//
//  GradientView.swift
//  DAYCE
//
//  Created by ひろ on 2023/03/19.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}
struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
