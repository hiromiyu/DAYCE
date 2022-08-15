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
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var scale: CGFloat = 1.0
    @State var initialScale: CGFloat = 1.0
    @State var tapped = false
    
//    var tap: some Gesture {
//        TapGesture(count: 2)
//            .onEnded { _ in self.tapped = !self.tapped }
//    }
    
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
        
       
        
        ScrollView {
            Text(samples.wrappedText)
                            .frame(width: 350)
//            VStack {
            if samples.image1?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 400, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .onTapGesture(count: 2) {
                        scale = 1.0
                    }
                    .offset(offset)
                    .scaleEffect(scale)
//                    .gesture(tap)
                    .gesture(SimultaneousGesture(magnificationGesture, dragGesture))
//                    .animation(.default)
            }
            if samples.image2?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg2)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .padding()
                    .offset(offset)
                    .scaleEffect(scale)
                    .gesture(dragGesture)
                    .simultaneousGesture(magnificationGesture)
//                    .animation(.default)
//                }
            }
        }
    }
}
