//
//  FullPhotoView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/10/08.
//

import SwiftUI

struct FullPhotoView: View {
    @ObservedObject var samples : SampleData
    @State private var min: CGFloat = 1.0
    @State private var max: CGFloat = 3.0
    @State var currentScale: CGFloat = 1.0
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var rotationData: RotationData
    @State private var rotation: Double = 0.0
    
    var body: some View {
        VStack {
            if samples.wrappedImg1.count == 0 {
                Text(samples.wrappedText)
            } else {
                ZoomableScrollView{
                    if samples.image1?.count ?? 0
                        != 0 {
                        Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(5)
                            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                            .navigationBarTitleDisplayMode(.inline)
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
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onTapGesture {
            dismiss()
        }
    }
}
