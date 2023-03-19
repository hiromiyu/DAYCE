//
//  MyButtonStyle.swift
//  DAYCE
//
//  Created by ひろ on 2022/12/24.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
          .background(configuration.isPressed ? Color.gray : Color.clear)
  }

}


