//
//  ScrollTabView.swift
//  DAYCE
//
//  Created by ひろ on 2022/12/20.
//

import SwiftUI

struct ScrollTabView: View {
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
                .frame(width: 70, height: 70)
                .cornerRadius(20)
        }
    }
}
