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
        GridItem(.adaptive(minimum: 50, maximum: .infinity))
    ]
    @State var isShow: Bool = false
    
    var body: some View {
//        VStack {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: grids) {
                    ForEach(sampleis) { samples in
                        PhotoCardView(samples: samples, sampleModel: sampleModel)
                        //                            NavigationLink {
                        //   PhotoScrollView(samples: samples)
                        //                                DayView(samples:samples)
                        //                            }
                        //                        PhotoView(samples: samples, sampleModel: sampleModel)
                        //                        label: { PhotoCardView(samples: samples, sampleModel: sampleModel)
                    }
                }
            .padding()
            }
        .navigationTitle("写真")
        .navigationBarTitleDisplayMode(.large)
//        .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(action:{
//                                            sampleModel.isNewData.toggle()
//                                        }){
//                                            Image(systemName: "plus")
//                                        }
//                                        .sheet(isPresented: $sampleModel.isNewData, content: {
//                                            SheetView(sampleModel: sampleModel)
//                        })
//                    }
//                }
//            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(samples: SampleData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
