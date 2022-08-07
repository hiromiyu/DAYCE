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
    private var samples: FetchedResults<SampleData>
    
    let grids = [
        GridItem(.adaptive(minimum: 50, maximum: .infinity))
    ]
    
    var body: some View {
        VStack {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: grids) {
                ForEach(samples) { item in
                    NavigationLink {
                        PhotoView(samples: item)
                    } label: {
                        PhotoCardView(samples: item, sampleModel: sampleModel) }
                    }
                }
            .padding()
            }
        .navigationTitle("写真")
        .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action:{
                                            sampleModel.isNewData.toggle()
                                        }){
                                            Text("追加")
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

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
