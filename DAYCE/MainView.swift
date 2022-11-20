//
//  MainView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()

    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var samples: FetchedResults<SampleData>
    
    @State private var selectedTag = 1
    
    var body: some View {
            TabView(selection: $selectedTag) {
                ContentView(samples: SampleData())
                    .tabItem {
                        Image(systemName: "list.bullet")
//                        Text("リスト")
                    }.tag(1)
                
                ListScrollView(samples: SampleData())
                    .tabItem {
                        Image(systemName: "scroll")
//                        Text("日記")
                    }.tag(2)
                
                LibraryView(samples: SampleData())
                    .tabItem {
                        Image(systemName: "photo.on.rectangle")
//                        Text("写真一覧")
                    }.tag(3)
                
                PhotoScrollView(samples: SampleData())
                    .tabItem {
                        Image(systemName: "scroll.fill")
//                        Text("写真")
                    }.tag(4)
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape")
//                        Text("設定")
                    }.tag(5)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewInterfaceOrientation(.portrait)
            .environmentObject(ColorData())
    }
}
