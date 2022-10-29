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
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("初めに").font(.title)) {
                    Text("日記リストの＋を押します")
                    Text("日付をカレンダーから選択します")
                    Text("日記を書いて写真を選択します")
                    Text("お気に入りにしたい時は❤️を押します")
                    Text("追加を押します")
                }
                Section(header: Text("日記リスト").font(.title)) {
                    Text("お気に入りボタンで絞り込みできます")
                    Text("タップで日記の表示、非表示ができます")
                    Text("長押しで編集、削除ができます")
                    Text("左スワイプでも削除できます")
                }
                Section(header: Text("日記").font(.title)) {
                    Text("日記を縦スクロールで見れます")
                }
                Section(header: Text("写真一覧").font(.title)) {
                    Text("タップで写真の表示、非表示ができます")
                }
                Section(header: Text("写真").font(.title)) {
                    Text("写真を横スクロールで見れます")
                }
                Section(header: Text("写真ズーム").font(.title)) {
                    Text("ピンチインでできます")
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
