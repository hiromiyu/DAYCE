//
//  ListScrollView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/10/02.
//

import SwiftUI

struct ListScrollView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    @State var isShowDetail: Bool = false
    
    var body: some View {
        ScrollView {
                LazyVStack {
                        ForEach(sampleis) { item in
                            Mone(samples: item, isShowDetail: $isShowDetail) }
                        .scaledToFit()
//                        .frame(width: .infinity, height: .infinity)
//                        .frame(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//                    .tabViewStyle(PageTabViewStyle())
//                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            }
        }
    }
}
