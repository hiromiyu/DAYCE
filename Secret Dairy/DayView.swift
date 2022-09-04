//
//  DayView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/21.
//

import SwiftUI

struct DayView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData
    
    var body: some View {
                ScrollView {
            Text(samples.wrappedText)
                .frame(width: 350)
            if samples.image1?.count ?? 0
                != 0 {
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    }
            if samples.image2?.count ?? 0
                != 0 {
                    Image(uiImage: UIImage(data: samples.wrappedImg2)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
            }
        }
    }
}

