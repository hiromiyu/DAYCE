//
//  ContentView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/07/30.
//

import SwiftUI
import CoreData
import PhotosUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData

    @State private var showFavoritesOnly = false
    
    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool)
        }
    }
    @State private var searchText: String = ""
    @State private var selectedTag = 1
    
    var body: some View {
                NavigationView {
                        List {
                            Toggle(isOn: $showFavoritesOnly) {
                                Text("お気に入り")
                            }
                            ForEach(filteredsamples) { samples in
                                NavigationLink {
                                    Mone(samples: samples)
                                } label: {
                                    SampleCardView(sampleModel: sampleModel, samples: samples)
                                }
                            }
                            .onDelete(perform: deleteMemo(offsets:))
                        }
                        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "検索")
                        .onChange(of: searchText) { newValue in
                            searchResults(texts: newValue)
                        }
                        .navigationTitle("リスト")
                        .navigationBarTitleDisplayMode(.large)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                HStack {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(samples: SampleData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
