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
    @State private var rotation: Double = 0.0

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var colorData: ColorData
    @EnvironmentObject var rotationData: RotationData
    @EnvironmentObject var speechbubbleData: SpeechbubbleData
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    let minScale = 0.2
    let maxScale = 5.0
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { offset = CGSize(width: initialOffset.width + $0.translation.width,
                                         height: initialOffset.height + $0.translation.height)
            }
            .onEnded { _ in initialOffset = offset }
        
            if samples.image1?.count ?? 0
                != 0 {
                if speechbubbleData.isOn && samples.wrappedText.count > 0 {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .addPinchZoom()
                        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                        .overlay(
                            BalloonText(samples.wrappedText)
                                .foregroundColor(.black)
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
                                .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            .background(.ultraThinMaterial)
                        }
                } else if speechbubbleData.positionlefttop && samples.wrappedText.count > 0 {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .addPinchZoom()
                        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                        .overlay(
                            BalloonText(samples.wrappedText, mirrored: true)
                                .foregroundColor(.black)
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
                                .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            .background(.ultraThinMaterial)
                        }
                } else if speechbubbleData.positionleftunder && samples.wrappedText.count > 0 {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .addPinchZoom()
                        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                        .overlay(
                            BalloonText(samples.wrappedText, mirrored: true)
                                .foregroundColor(.black)
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
                                .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            .background(.ultraThinMaterial)
                        }
                } else if speechbubbleData.positionrightunder && samples.wrappedText.count > 0 {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .addPinchZoom()
                        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                        .overlay(
                            BalloonText(samples.wrappedText)
                                .foregroundColor(.black)
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
                                .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            .background(.ultraThinMaterial)
                        }
                } else {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .addPinchZoom()
                        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                    
                        .overlay(
                            Text(samples.wrappedText)
                                .foregroundColor(colorScheme == .light ? colorData.colorViews[colorData.selectedColor] : colorData.darkcolorViews[colorData.selectedColor])
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
                                .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.primary)
                            .background(.ultraThinMaterial)
                        }
                }
        
                if rotationData.isOn {
                    Spacer()
                    HStack {
                        Text(String(Int(rotation)))
                            .frame(width: 40)
                        Slider(value: $rotation, in: 0...360)
                            .frame(width: 300)
                    }
                    Spacer()
                }
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


