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
    
    @State var selectedTag = 1
    init() {
        UITabBar.appearance().backgroundColor = .systemGray6
    }
    
    var body: some View {
        TabView(selection: $selectedTag) {
            ContentView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("リスト")
                }.tag(1)
            
            LibraryView()
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("写真")
                }.tag(2)
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("設定")
                }.tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
