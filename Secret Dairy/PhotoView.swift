//
//  PhotoView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/02.
//

import SwiftUI

struct PhotoView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData
    @ObservedObject var sampleModel: SampleModel
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var scale: CGFloat = 1.0
    @State var initialScale: CGFloat = 1.0
    @State var tapped = false
    @State private var rotation = Angle.zero
    
    var rotationGesture: some Gesture {
        RotationGesture()
            .onChanged { angle in
                rotation = angle
            }
            .onEnded { angle in
                rotation = angle
            }
    }
    
    var body: some View {
        let magnificationGesture = MagnificationGesture()
            .onChanged { scale = $0 * initialScale
                if scale < 1.0 {
                    scale = 1.0
                }
            }
            .onEnded { _ in initialScale = scale }
        let dragGesture = DragGesture()
            .onChanged { offset = CGSize(width: initialOffset.width + $0.translation.width,
                                         height: initialOffset.height + $0.translation.height)
            }
            .onEnded { _ in initialOffset = offset }
//        ScrollView {
            if samples.image1?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .offset(offset)
                    .scaleEffect(scale)
                    .rotationEffect(rotation)
//                    .gesture(magnificationGesture)
                    .gesture(SimultaneousGesture(magnificationGesture, dragGesture))
            }
            if samples.image2?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg2)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(offset)
                    .scaleEffect(scale)
//                    .gesture(dragGesture)
//                    .simultaneousGesture(magnificationGesture)
//            }
        }
    }
}
