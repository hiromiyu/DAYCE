//
//  LibraryView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct LibraryView: View {
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    
    let grids = [
        GridItem(.adaptive(minimum: 60, maximum: .infinity))
    ]
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: grids, spacing: 0) {
                    ForEach(sampleis.indices, id: \.self) { item in
                        NavigationLink(destination: {
                            ImagePager(samples: sampleis[item], selectedTag: item)
                        }, label: {
                            PhotoCardView(samples: sampleis[item])
                        })
                    }
                }
                .padding()
            }
            .navigationTitle("写真")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("閉じる")
                    }
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(isPresented: Binding.constant(false))
    }
}
