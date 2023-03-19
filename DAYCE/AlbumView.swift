//
//  AlbumView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/04.
//

import SwiftUI
import PhotosUI
import Combine

struct AlbumView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    @ObservedObject var sampleModel: SampleModel
    @EnvironmentObject var albumName: AlbumName
    @State private var showFavoritesOnly = true
    @State private var showNewAlbumOnly = true
    @State var photoLibraryDone: Bool = false
    @State var FavoritesDone: Bool = false
    @State var NewAlbumDone: Bool = false
    @State private var isPicking: Bool = false
    @State private var images: [Data] = []
    
    var pickerConfig: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 1
        return config
    }
    
    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool)
        }
    }
    var filteredAlbums: [SampleData] {
        sampleis.filter { sample in
            (!showNewAlbumOnly || sample.bool2)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        if sampleis.count >= 1 {
                            Button(action:{
                                photoLibraryDone.toggle()
                            })
                            {
                                VStack(alignment: .leading) {
                                    AlbumCardView(samples: sampleis[0], sampleModel: sampleModel)
                                    Text("写真一覧")
                                    Text("\(sampleis.count)")
                                }
                            }.padding()
                                .fullScreenCover(isPresented: $photoLibraryDone)
                            {
                                LibraryView(samples: SampleData(), isPresented: $photoLibraryDone)
                            }
                        }
                        Spacer()
                        if filteredsamples.count >= 1 {
                            Button(action:{
                                FavoritesDone.toggle()
                            })
                            {
                                VStack(alignment: .leading) {
                                    AlbumCardView(samples: filteredsamples[0], sampleModel: sampleModel)
                                    Text("お気に入り")
                                    Text("\(filteredsamples.count)")
                                }
                            }.padding()
                                .fullScreenCover(isPresented: $FavoritesDone)
                            {
                                FavoritesView(samples: SampleData(), isPresented: $FavoritesDone)
                            }
                        }
                    }
                    
                    if filteredAlbums.count >= 1 {
                        Button(action:{
                            NewAlbumDone.toggle()
                        })
                        {
                            VStack(alignment: .leading) {
                                AlbumCardView(samples: filteredAlbums[0], sampleModel: sampleModel)
                                Text("\(albumName.name)")
                                Text("\(filteredAlbums.count)")
                            }
                        }.padding()
                            .fullScreenCover(isPresented: $NewAlbumDone)
                        {
                            NewAlbumView(samples: SampleData(), isPresented: $NewAlbumDone)
                        }
                    }
                    
                }
            }.navigationTitle("アルバム")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
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

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(samples: SampleData(), sampleModel: SampleModel())
            .environmentObject(AlbumName())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
