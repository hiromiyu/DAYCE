//
//  ZoomView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/09/18.
//

import SwiftUI

struct ZoomView: View {
    @Environment(\.managedObjectContext)
    private var context
    @EnvironmentObject var colorData: ColorData
    @EnvironmentObject var speechbubbleData: SpeechbubbleData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var samples : SampleData
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var scale: CGFloat = 1.0
    @State var initialScale: CGFloat = 1.0
        
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { offset = CGSize(width: initialOffset.width + $0.translation.width,
                                         height: initialOffset.height + $0.translation.height)
            }
            .onEnded { _ in initialOffset = offset }
        
        if samples.image1?.count ?? 0 != 0 {
            if speechbubbleData.isOn && samples.wrappedText.count > 0 {
                ZoomableScrollView {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                .edgesIgnoringSafeArea(.all)
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
            } else if speechbubbleData.positionlefttop && samples.wrappedText.count > 0 {
                ZoomableScrollView {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                .edgesIgnoringSafeArea(.all)
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
            } else if speechbubbleData.positionleftunder && samples.wrappedText.count > 0 {
                ZoomableScrollView {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                .edgesIgnoringSafeArea(.all)
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
            } else if speechbubbleData.positionrightunder && samples.wrappedText.count > 0 {
                ZoomableScrollView {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                .edgesIgnoringSafeArea(.all)
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
            } else {
                ZoomableScrollView {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    Text(samples.wrappedText)
                        .foregroundColor(colorScheme == .light ? colorData.colorViews[colorData.selectedColor] : colorData.darkcolorViews[colorData.selectedColor])
                        .font(.largeTitle)
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(dragGesture)
                        .onLongPressGesture(perform: {
                            scale = 0
                        })
                        .onTapGesture {
                            if scale > 1.0 {
                                scale = 1.0
                            } else {
                                scale = 2.0
                            }
                        }
                        .animation(.spring(), value: scale)
                )
            }
        }
    }
}
