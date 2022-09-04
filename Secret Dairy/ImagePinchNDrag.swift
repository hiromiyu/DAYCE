//
//  ImagePinchNDrag.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/21.
//

import SwiftUI

struct ImagePinchNDrag: View {
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State private var currentScale: CGFloat = 1
    @State private var newScale: CGFloat = 1

    
    var body: some View {
        
        let pinchGesture = MagnificationGesture()
            .onChanged { (value) in
                currentScale = CGFloat(value + newScale)-1
            }
            .onEnded { value in
                newScale = currentScale
            }
        
        let dragGesture = DragGesture()
            .onChanged { (value) in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
            }
            .onEnded { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                self.newPosition = self.currentPosition
            }
        
        let pinchNDrag = dragGesture.simultaneously(with: pinchGesture)
        
        VStack {
            Spacer()
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal)
                .zIndex(1.0)
                .scaleEffect(max(currentScale,1))
                .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                .gesture(pinchNDrag)
            Spacer()
        }
    }
}

struct ImagePinchNDrag_Previews: PreviewProvider {
    static var previews: some View {
        ImagePinchNDrag()
    }
}
