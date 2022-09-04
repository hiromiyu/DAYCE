//
//  ImageViewer.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/12.
//

import SwiftUI

struct ImageViewer: UIViewRepresentable {
let imageName: String
func makeUIView(context: Context) -> UIImageViewerView {
let view = UIImageViewerView(imageName: imageName)
return view
    }
func updateUIView(_ uiView: UIImageViewerView, context: Context) {}
}
