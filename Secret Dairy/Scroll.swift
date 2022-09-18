//
//  Scroll.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/09/04.
//

import SwiftUI

struct Scroll: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @StateObject private var sampleModel = SampleModel()
    @ObservedObject var sampleModel: SampleModel


    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sample: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    
    @State private var index: Int = 0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
//        TabView {
        ForEach(sample) { sample in
            PhotoView(samples: sample, sampleModel: sampleModel)
                }.frame(width: geometry.size.width, height: geometry.size.width)
            }
        
//        .frame(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//        .tabViewStyle(PageTabViewStyle())
//        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
//        .ignoresSafeArea()
//        }
        }
            .content.offset(x: self.offset)
            .frame(width: geometry.size.width, height: nil, alignment: .leading)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                })
                .onEnded({ value in
                    let scrollThreshold = geometry.size.width / 2
                    if value.predictedEndTranslation.width < -scrollThreshold {
                        self.index = min(self.index + 1, self.sample.endIndex - 1)
                    } else if value.predictedEndTranslation.width > scrollThreshold {
                        self.index = max(self.index - 1, 0)
                    }

                    withAnimation {
                        self.offset = -geometry.size.width * CGFloat(self.index)
                    }
                })
            )
        }
    }
}
