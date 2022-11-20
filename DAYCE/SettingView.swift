//
//  SettingView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct webData: Identifiable {
    var id = UUID()
    var name: String
    var url: String
}

struct SettingView: View {
    
    let weblist =
    webData(name: "問い合わせはこちら", url: "https://docs.google.com/forms/d/e/1FAIpQLSfykjA3rGBDPq5Q2lpwHuKZ8a1mnxvnoLnLL1q1Cccq5S5hzQ/viewform?usp=sf_link")
    
    let colors = ["白", "黒", "赤", "緑", "青", "黄", "ピンク", "紫", "オレンジ","茶"]
    
    @EnvironmentObject var colorData: ColorData
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("日記の文字の色").font(.headline)) {
                    Picker(selection: $colorData.selectedColor, label: Text("色")) {
                        ForEach(0..<colors.count, id: \.self) { index in
                            Text(colors[index])
                        }
                    }
                    colorData.colorViews[colorData.selectedColor]
                        .cornerRadius(10)
                }
            }
            .frame(height: 150)
                NavigationView {
                    List {
                        Section(header: Text("初めに").font(.title)) {
                            Text("リストの右上のペンマークを押します")
                            Text("日付をカレンダーから選択します")
                            Text("日記を書いて写真を選択します")
                            Text("お気に入りにしたい時は❤️を押します")
                            Text("保存を押します")
                        }
                        Section(header: Text("リスト").font(.title)) {
                            Text("日記を文字で検索できます")
                            Text("お気に入りボタンで絞り込みできます")
                            Text("タップで日記の表示、非表示ができます")
                            Text("長押しで編集、削除ができます")
                            Text("左スワイプでも削除できます")
                        }
                        Section(header:                         Image(systemName: "scroll")
                                .font(.title)) {
                            Text("縦スクロールで見れます")
                            Text("設定画面で文字の色を変更できます")
                            Text("写真内で文字を動かせます")
                            Text("文字をタップすると少し大きくなります")
                        }
                        Section(header: Text("写真").font(.title)) {
                            Text("タップで写真の表示、非表示ができます")
                        }
                        Section(header:
                                Image(systemName:"scroll.fill")
                                .font(.title)) {
                            Text("横スクロールで見れます")
                            Text("設定画面で文字の色を変更できます")
                            Text("写真内で文字を動かせます")
                            Text("文字をタップすると少し大きくなります")
                        }
                        Section(header: Text("写真ズーム").font(.title)) {
                            Text("ピンチインで写真を拡大できます")
                        }
                        Section(header: Text("注意！")
                            .font(.title)
                            .foregroundColor(.red)) {
                                Text("日記を削除すると元には戻せません！")
                                    .foregroundColor(.red)
                                Text("アプリを削除するとデータも消えます！")
                                    .foregroundColor(.red)
                            }
                        Link(weblist.name, destination: URL(string: weblist.url)!)
                            .foregroundColor(.blue)
                        
                        NavigationLink(destination: PrivacyView()) {
                            Text("プライバシーポリシー")
                                .foregroundColor(.blue)
                        }
                        NavigationLink(destination: Terms_Of_ServiceView()) {
                            Text("利用規約")
                                .foregroundColor(.blue)
                            
                        }
                    }.listStyle(.sidebar)
                        .navigationTitle(Text("使い方"))
                
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(ColorData())
    }
}
