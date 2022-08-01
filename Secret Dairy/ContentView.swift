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
                Text("追加")
                Image(systemName: "pencil.and.outline")
                    .frame(width: 50.0, height: 50.0)
            }
            .frame(width: 130, height: 60, alignment: .center)
            .foregroundColor(Color.white)
            .background(Color.black)
            .imageScale(.large)
            .padding()
            .sheet(isPresented: $sampleModel.isNewData, content: {
                SheetView(sampleModel: sampleModel)
            })
            NavigationView {
            List{
                ForEach(samples) { samples in
                    SampleCardView(sampleModel: sampleModel, samples: samples)
                    }
                }
            .navigationTitle("日記")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
