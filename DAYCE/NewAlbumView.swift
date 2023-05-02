//
//  NewAlbumView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/15.
//

import SwiftUI
import Combine

struct NewAlbumView: View {
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @EnvironmentObject var albumName: AlbumName
    
    let grids = [
        GridItem(.adaptive(minimum: 60, maximum: .infinity))
    ]
    @Binding var isPresented: Bool
    @State private var showNewAlbumOnly = true
    @State var istltle = false
    
    var filteredAlbums: [SampleData] {
        sampleis.filter { sample in
            (!showNewAlbumOnly || sample.bool2)
        }
    }
    let textLimit = 9
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { proxy in
                    LazyVGrid(columns: grids, spacing: 0) {
                        ForEach(filteredAlbums.indices, id: \.self) { item in
                            NavigationLink(destination: {
                                NewAlbumPager(samples: filteredAlbums[item], selectedTag: item)
                            }, label: {
                                PhotoCardView(samples: filteredAlbums[item])
                            })
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(albumName.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        istltle = true
                    }){
                        Image(systemName: "square.and.pencil")
                    }
                    .alert("⭐️アルバム", isPresented: $istltle) {
                        TextField("アルバム名", text: $albumName.name)
                            .onReceive(Just(albumName.name)){
                                _ in
                                if albumName.name.count > textLimit {
                                    albumName.name = String(albumName.name.prefix(textLimit))
                                }
                            }
                        Button("保存"){
                        }
                    }
                message: {
                    Text("アルバムの名前を入力して下さい。")
                }
                }
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

struct NewAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlbumView(isPresented: Binding.constant(false))
            .environmentObject(AlbumName())
    }
}
