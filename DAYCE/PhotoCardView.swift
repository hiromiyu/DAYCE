//
//  PhotoCardView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct PhotoCardView: View {
    @ObservedObject var samples: SampleData
    
    var body: some View {
        if samples.image1?.count ?? 0
            != 0 {
            Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipped()
        } else {
            CustomImageMini()
        }
    }
}
