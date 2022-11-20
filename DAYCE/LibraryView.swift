//
//  LibraryView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    
    let grids = [
        GridItem(.adaptive(minimum: 60, maximum: .infinity))
    ]
    @State var isShow: Bool = false
    @State var isShowDetail: Bool = false
    
    var body: some View {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: grids, spacing: 0) {
                            ForEach(sampleis) { samples in
                                PhotoCardView(samples: samples, sampleModel: sampleModel)
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("写真")
                    .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(samples: SampleData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
