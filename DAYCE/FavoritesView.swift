//
//  FavoritesView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/13.
//

import SwiftUI

struct FavoritesView: View {
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    
    let grids = [
        GridItem(.adaptive(minimum: 60, maximum: .infinity))
    ]
    
    @Binding var isPresented: Bool
    @State private var showFavoritesOnly = true
    
    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool)
        }
    }
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { proxy in
                    LazyVGrid(columns: grids, spacing: 0) {
                        ForEach(filteredsamples.indices, id: \.self) { item in
                            NavigationLink(destination: {
                                FavoritesPager(samples: filteredsamples[item], selectedTag: item)
                            }, label: {
                                PhotoCardView(samples: filteredsamples[item])
                            })
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("お気に入り")
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(isPresented: Binding.constant(false))
    }
}
