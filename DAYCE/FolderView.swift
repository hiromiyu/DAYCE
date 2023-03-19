//
//  FolderView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/02.
//

import SwiftUI

struct FolderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    @State var photoLibraryDone: Bool = false
    @State private var searchText: String = ""
    @State private var showFavoritesOnly = false
    @State private var showNewAlbumOnly = false
    @EnvironmentObject var albumName: AlbumName
    
    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool) && (!showNewAlbumOnly || sample.bool2)
        }
    }
    let grids = [
        GridItem(.adaptive(minimum: 150, maximum: .infinity))
    ]
    var body: some View {
        NavigationView {
            ScrollView{
                Toggle(isOn: $showFavoritesOnly.animation(.spring())) {
                        Text("お気に入り")
                            .font(.headline)
                }.padding(.horizontal, 30.0)
                .disabled(showNewAlbumOnly)
                Toggle(isOn: $showNewAlbumOnly.animation(.spring())) {
                    Text("\(albumName.name)")
                            .font(.headline)
                }.padding(.horizontal, 30.0)
                .disabled(showFavoritesOnly)
                LazyVGrid(columns: grids, spacing: 20) {
                        ForEach(filteredsamples){ item in
                            NavigationLink {
                                Mone(samples: item)
                            } label: {
                                FolderCardView(samples: item, sampleModel: sampleModel)
                            }
                        }
                    }.padding()
                    .searchable(text: $searchText, prompt: "検索")
                    .onChange(of: searchText) { newValue in
                        searchResults(texts: newValue)}
            }
            .navigationTitle("日記")
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
    private func deleteMemo(offsets:IndexSet) {
        offsets.forEach { index in
            viewContext.delete(sampleis[index])
        }
        try? viewContext.save()
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

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView(samples: SampleData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(AlbumName())
    }
}
