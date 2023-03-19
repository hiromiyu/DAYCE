//
//  FavoritesView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/13.
//

import SwiftUI

struct FavoritesView: View {
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
    @State private var showFavoritesOnly = true
    @State var selectedTag = 0
    @State var isLink = false
    @State var emptySwitchON = false
    @Namespace var namespace
    
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
                    .searchable(text: $searchText, prompt: "検索")
                    .onChange(of: searchText) { newValue in
                        searchResults(texts: newValue)
                    }
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(samples: SampleData(), isPresented: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
