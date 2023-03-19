//
//  NewAlbumView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/15.
//

import SwiftUI
import Combine

struct NewAlbumView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    @EnvironmentObject var albumName: AlbumName

    let grids = [
        GridItem(.adaptive(minimum: 60, maximum: .infinity))
    ]
    @State var isShow: Bool = false
    @State var isShowDetail: Bool = false
    @Binding var isPresented: Bool
    @State private var searchText: String = ""
    @State private var showNewAlbumOnly = true
    @State var selectedTag = 0
    @State var isLink = false
    @State var emptySwitchON = false
    @State var istltle = false
    @Namespace var namespace
    
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
                            .searchable(text: $searchText, prompt: "検索")
                            .onChange(of: searchText) { newValue in
                                searchResults(texts: newValue)
                            }
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
    
    private func searchResults(texts: String) {
        if texts.isEmpty {
            sampleis.nsPredicate = nil
        } else {
            let datePredicate: NSPredicate = NSPredicate(format: "date contains %@", texts)
            let textPredicate: NSPredicate = NSPredicate(format: "text contains %@", texts)
            sampleis.nsPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [datePredicate, textPredicate])
        }
    }
}

struct NewAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        NewAlbumView(samples: SampleData(), isPresented: Binding.constant(false))
            .environmentObject(AlbumName())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
