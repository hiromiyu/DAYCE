//
//  PhotoScrollView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/10/02.
//

import SwiftUI

struct PhotoScrollView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData

    var body: some View {
        ScrollView (.horizontal) {
                LazyHStack {
//                    TabView {
                    ForEach(sampleis) { samples in
                        DayView(samples: samples)
                    }
//                }
                .frame(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//                  .tabViewStyle(PageTabViewStyle())
//                  .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            }
        }
            .ignoresSafeArea()
            .statusBarHidden()
    }
}
