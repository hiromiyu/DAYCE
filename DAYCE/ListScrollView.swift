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
    @State private var showFavoritesOnly = false
    @State private var showNewAlbumOnly = false
    @EnvironmentObject var albumName: AlbumName
    
    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool) && (!showNewAlbumOnly || sample.bool2)
        }
    }
    
    var body: some View {
            ScrollView {
                Toggle(isOn: $showFavoritesOnly.animation(.spring())) {
                        Text("お気に入り")
                            .font(.headline)
                }.padding([.top, .leading, .trailing], 20.0)
                    .disabled(showNewAlbumOnly)
                Toggle(isOn: $showNewAlbumOnly.animation(.spring())) {
                    Text("\(albumName.name)")
                            .font(.headline)
                }.padding([.top, .leading, .trailing], 20.0)
                    .disabled(showFavoritesOnly)
                
                LazyVStack {
                    ForEach(filteredsamples) { item in
                        PhotoView(samples: item)
                    }
                }                
            }
            .statusBarHidden()
    }
}
