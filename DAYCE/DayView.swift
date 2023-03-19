//
//  DayView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/21.
//

import SwiftUI

struct DayView: View{
    
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData
    @ObservedObject var sampleModel: SampleModel
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var scale: CGFloat = 1.0
    @State var initialScale: CGFloat = 1.0
    @State var tapped = false
    @State private var rotation: Double = 0.0

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var colorData: ColorData
    @EnvironmentObject var rotationData: RotationData

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
                        VStack {
                            ZoomableScrollView{
                                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(10)
                                    .statusBarHidden()
                                    .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                                
                            }
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
                            
                            
                            if rotationData.isOn {
                                HStack {
                                    Text(String(Int(rotation)))
                                        .frame(width: 40)
                                    Slider(value: $rotation, in: 0...360)
                                        .frame(width: 300)
                                }.padding()
                                Spacer()
                            }
                        }
        }
    }
}

