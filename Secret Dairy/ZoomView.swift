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
    @ObservedObject var samples : SampleData
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    
    var body: some View {
            if samples.image1?.count ?? 0 != 0 {
                GeometryReader { proxy in
                    Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipShape(Rectangle())
                        .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                }
                .ignoresSafeArea()
        }
    }
}
