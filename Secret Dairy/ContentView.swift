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
    private var samples: FetchedResults<SampleData>

    @State private var showFavoritesOnly = false
    @State private var selectedValue = Set<SampleData>()
    @State private var isShowingDialog = false
    @State var editMode: EditMode = .inactive
    
    var filteredsamples: [SampleData] {
        samples.filter { sample in
            (!showFavoritesOnly || sample.bool)
        }
    }
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            NavigationView {
                List(selection: $selectedValue) {
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("お気に入り")
                    }
                    ForEach(filteredsamples) { samples in
                        NavigationLink {
//                            DayView(samples: samples)
                            Mone(samples:samples)
                        } label: {
                            SampleCardView(sampleModel: sampleModel, samples: samples)
                        }
                    }
                    
                    .onDelete(perform: deleteMemo(offsets:))
                    
                }
                .navigationTitle("リスト")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action:{
                                sampleModel.isNewData.toggle()
                            }){
                                Image(systemName: "plus")
                            }
                            .sheet(isPresented: $sampleModel.isNewData, content: {
                                SheetView(sampleModel: sampleModel)
                            })
//                            EditButton()
                        }
                    }
                }
                
                .environment(\.editMode, $editMode)
                
            }
       /*     if editMode.isEditing {
                Button(action: {
                    isShowingDialog = true
                }) {
                    Image(systemName: "trash")
                }.confirmationDialog("注意!", isPresented: $isShowingDialog) {
                    Button("削除する", role: .destructive) {
                        onDeleteSelectedButton()
                    }
                    Button("キャンセル", role: .cancel) {
                        
                    }
                } message: {
                    Text("削除すると戻せません")
                }
                .disabled(selectedValue.count == 0)
                .padding()
            }
            */
        }
    }
    public func onDeleteSelectedButton() {
        for item in selectedValue {
            viewContext.delete(item)
        }
        selectedValue = Set<SampleData>()
    }
    
    private func deleteMemo(offsets:IndexSet) {
        offsets.forEach { index in
            viewContext.delete(samples[index])
        }
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
