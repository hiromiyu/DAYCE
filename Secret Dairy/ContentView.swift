//
//  ContentView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/07/30.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var samples: FetchedResults<SampleData>
    @State private var bool = false
    
    var body: some View {
        VStack {
            NavigationView {
                List{
                    ForEach(samples) { samples in
                        NavigationLink {
                            PhotoView(samples: samples)
                        } label: {
                            SampleCardView(sampleModel: sampleModel, samples: samples)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive, action: {
                                        viewContext.delete(samples)
                                        try!
                                        viewContext.save()
                                    }){
                                        Text("削除")
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    .onDelete {_ in
                    }
                }
                .navigationTitle("リスト")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action:{
                                sampleModel.isNewData.toggle()
                            }){
                                Text("追加")
                            }
                            .sheet(isPresented: $sampleModel.isNewData, content: {
                                SheetView(sampleModel: sampleModel)
                            })
//                            EditButton()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
