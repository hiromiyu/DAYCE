//
//  TwitterView.swift
//  DAYCE
//
//  Created by ひろ on 2023/04/28.
//

import SwiftUI

struct TwitterView: View {
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    @StateObject private var sampleModel = SampleModel()
    @State private var showFavoritesOnly = false
    @State private var showNewAlbumOnly = false
    @EnvironmentObject var albumName: AlbumName
    
    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool) && (!showNewAlbumOnly || sample.bool2)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(filteredsamples) { item in
                            NavigationLink(destination: {
                                FullPhotoView(samples: item)
                            }, label: {
                                MiniView(samples: item, sampleModel: sampleModel)
                                    .padding()
                            })
                        }
                    }
                }
            .navigationTitle(Text("Diary"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Toggle(isOn: $showFavoritesOnly) {
                            Image(systemName: "heart")
                                .font(.headline)
                        }
                            .disabled(showNewAlbumOnly)
                        Toggle(isOn: $showNewAlbumOnly) {
                            Image(systemName: "star")
                                .font(.headline)
                        }
                            .disabled(showFavoritesOnly)
                        Button(action:{
                            sampleModel.isNewData.toggle()
                        }){
                            Image(systemName: "pencil.and.outline")
                        }
                        .sheet(isPresented: $sampleModel.isNewData, content: {
                            SheetView(sampleModel: sampleModel)
                        })
                    }
                }
            }
        }
    }
}

struct TwitterView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterView(samples: SampleData())
            .environmentObject(AlbumName())
    }
}
