//
//  MessWithPhotoView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/15.
//

import SwiftUI

struct MessWithPhotoView: View {
    
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var scale: CGFloat = 1.0
    @State var initialScale: CGFloat = 1.0
    
    var body: some View {
        let magnificationGesture = MagnificationGesture()
            .onChanged { scale = $0 * initialScale
                if scale < 1.0 {
                    scale = 1.0
                }
            }
            .onEnded { _ in initialScale = scale }
        let dragGesture = DragGesture()
            .onChanged { offset = CGSize(width: initialOffset.width + $0.translation.width, height: initialOffset.height + $0.translation.height) }
            .onEnded { _ in initialOffset = offset }
        
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .onTapGesture(count: 2) {
                        scale = 1.0
                    }
                    .offset(offset)
                    .scaleEffect(scale)
                    .gesture(SimultaneousGesture(magnificationGesture, dragGesture))
    }
}

