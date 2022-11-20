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
    @State private var rotation = Angle.zero
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var colorData: ColorData
    let minScale = 0.2
    let maxScale = 5.0
    
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
        let dragGesture = DragGesture()
            .onChanged { offset = CGSize(width: initialOffset.width + $0.translation.width,
                                         height: initialOffset.height + $0.translation.height)
            }
            .onEnded { _ in initialOffset = offset }
        
            if samples.image1?.count ?? 0
                != 0 {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .addPinchZoom()
                .overlay(
                    Text(samples.wrappedText)
                        .foregroundColor(colorData.colorViews[colorData.selectedColor])
                        .font(.largeTitle)
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(dragGesture)
                        .onTapGesture {
                            if scale > 1.0 {
                                scale = 1.0
                            } else {
                                scale = 2.0
                            }
                        }
                        .animation(.spring(), value: scale)
                )
                .onTapGesture {
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        dismiss()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .top) {
                    HStack {
                        Spacer()
                    }
                    .overlay {
                        Text(samples.wrappedDate,
                             formatter: itemFormatter)
                    }
                    .padding()
                    .foregroundColor(.primary)
                    .background(.ultraThinMaterial)
                }
            }
            if samples.image2?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg2)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(offset)
                    .scaleEffect(scale)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.locale = Locale(identifier: "ja_JP")
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.dateFormat = "yyyy年MM月dd日"
            return formatter
        }()
}


