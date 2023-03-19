//
//  AlbumCardView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/18.
//

import SwiftUI

struct AlbumCardView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples: SampleData
    @ObservedObject var sampleModel: SampleModel
    
    var body: some View {
        if samples.image1?.count ?? 0
            != 0 {
            Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(20)
        }
    }
}
