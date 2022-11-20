//
//  ColorData.swift
//  DAYCE
//
//  Created by ひろ on 2022/11/04.
//

import Foundation
import SwiftUI

class ColorData: ObservableObject {
    @Published var colorViews: [Color] = [.white, .black, .red, .green, .blue, .yellow, .pink, .purple, .orange, .brown]
    @Published var selectedColor: Int = 0
}
