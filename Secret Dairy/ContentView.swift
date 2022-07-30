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

    var body: some View {
        
        VStack {
            Button(action:{
                sampleModel.isNewData.toggle()
            }){
                Text("日記 追加")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
            }
            .sheet(isPresented: $sampleModel.isNewData, content: {
                SheetView(sampleModel: sampleModel)
            })
        
            List{
                ForEach(samples) {samples in
                    SampleCardView(sampleModel: sampleModel, samples: samples)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
