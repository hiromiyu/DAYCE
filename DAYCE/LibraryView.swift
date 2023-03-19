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
    @Binding var isPresented: Bool
    @State private var searchText: String = ""
    @State private var showFavoritesOnly = false
    @State private var showNewAlbumOnly = false
    @EnvironmentObject var albumName: AlbumName
    @State var selectedTag = 0
    @State var isLink = false
    @State var emptySwitchON = false
    @Namespace var namespace
    
    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool) && (!showNewAlbumOnly || sample.bool2)
        }
    }
    
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
                        .searchable(text: $searchText, prompt: "検索")
                        .onChange(of: searchText) { newValue in
                            searchResults(texts: newValue)
                        }
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

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(samples: SampleData(), isPresented: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(AlbumName())
    }
}
