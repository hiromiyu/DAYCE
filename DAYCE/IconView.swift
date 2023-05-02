//
//  IconView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/16.
//

import SwiftUI
import CoreData

struct IconView: View {
    @ObservedObject var samples : SampleData
    
    var body: some View {
        if samples.image1?.count ?? 0
            != 0 {
            Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(20)
        } else {
            CustomImage()
        }
    }
}

