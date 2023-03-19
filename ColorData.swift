//
//  ColorData.swift
//  DAYCE
//
//  Created by ひろ on 2022/11/04.
//

import Foundation
import SwiftUI

class ColorData: ObservableObject {
    @Published var colorViews: [Color] = [.black, .purple, .red, .green, .blue, .yellow, .pink, .orange, .brown]
    @Published var darkcolorViews: [Color] = [.white, .purple, .red, .green, .blue, .yellow, .pink, .orange, .brown]
    @Published var selectedColor: Int = 0
}
