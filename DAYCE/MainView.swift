//
//  MainView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var colorData: ColorData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var selectedTag = 1
    
    var body: some View {
        TabView(selection: $selectedTag) {
            
            TwitterView(samples: SampleData())
                .tabItem {
                    Image(systemName: "scroll.fill")
                    Text("Diary")
                }.tag(1)
            
            ContentView(samples: SampleData())
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }.tag(2)
            
            AlbumView(samples: SampleData(), sampleModel: SampleModel())
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Album")
                }.tag(3)
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Setting")
                }.tag(4)
        }
        .accentColor(colorScheme == .light ? colorData.colorViews[colorData.selectedColor] : colorData.darkcolorViews[colorData.selectedColor])
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ColorData())
            .environmentObject(RotationData())
            .environmentObject(AlbumName())
            .environmentObject(SpeechbubbleData())
    }
}
