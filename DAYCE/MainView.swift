//
//  MainView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var colorData: ColorData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @StateObject private var sampleModel = SampleModel()

//    @FetchRequest(
//        entity:SampleData.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
//        animation: .default)
//    private var samples: FetchedResults<SampleData>
    
    @State private var selectedTag = 1
    
    var body: some View {
            TabView(selection: $selectedTag) {
                ContentView(samples: SampleData())
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }.tag(1)
                
                FolderView(samples: SampleData())
                    .tabItem {
                        Image(systemName: "doc.text.image")
                    }.tag(2)
                
                ListScrollView(samples: SampleData())
                    .tabItem {
                        Image(systemName: "scroll.fill")
                    }.tag(3)
                
                AlbumView(samples: SampleData(), sampleModel: SampleModel())
                    .tabItem {
                        Image(systemName: "book.fill")
                    }.tag(4)
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape")
                    }.tag(5)
            }
            .accentColor(colorScheme == .light ? colorData.colorViews[colorData.selectedColor] : colorData.darkcolorViews[colorData.selectedColor])
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewInterfaceOrientation(.portrait)
            .environmentObject(ColorData())
            .environmentObject(RotationData())
            .environmentObject(AlbumName())
            .environmentObject(SpeechbubbleData())
    }
}
