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
    webData(name: "問い合わせはこちら", url: "https://assgin.pythonanywhere.com")
    //    webData(name: "問い合わせはこちら", url: "https://docs.google.com/forms/d/e/1FAIpQLSfykjA3rGBDPq5Q2lpwHuKZ8a1mnxvnoLnLL1q1Cccq5S5hzQ/viewform?usp=sf_link")
    
    let colors = ["黒", "紫", "赤", "緑", "青", "黄", "ピンク", "オレンジ","茶"]
    let darkcolors = ["白", "紫", "赤", "緑", "青", "黄", "ピンク", "オレンジ","茶"]
    
    let speech = ["右上", "左上"]
    
    @EnvironmentObject var colorData: ColorData
    @EnvironmentObject var rotationData: RotationData
    @EnvironmentObject var speechbubbleData: SpeechbubbleData
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedSpeech = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("テーマカラー")
                    .font(.headline)) {
                        if colorScheme == .light {
                            Picker(selection: $colorData.selectedColor, label: Text("色")
                                .font(.headline)) {
                                    ForEach(0..<colors.count, id: \.self) { index in
                                        Text(colors[index])
                                    }
                                }
                            colorData.colorViews[colorData.selectedColor]
                                .cornerRadius(10)
                        } else if colorScheme == .dark {
                            Picker(selection: $colorData.selectedColor, label: Text("色")
                                .font(.headline)) {
                                    ForEach(0..<darkcolors.count, id: \.self) { index in
                                        Text(darkcolors[index])
                                    }
                                }
                            colorData.darkcolorViews[colorData.selectedColor]
                                .cornerRadius(10)
                        }
                    }
                Section(header:
                            Text("写真回転")
                    .font(.headline)) {
                        Toggle(isOn: $rotationData.isOn) {
                            Text("回転 : \(rotationData.isOn ? "ON" : "OFF")")
                                .font(.headline)
                        }
                    }
                
                Section(header:
                            Text("吹き出し追加")
                    .font(.headline)) {
                        Toggle(isOn: $speechbubbleData.isOn) {
                            Text("吹き出し右上 : \(speechbubbleData.isOn ? "ON" : "OFF")")
                                .font(.headline)
                        }.disabled(speechbubbleData.positionlefttop || speechbubbleData.positionleftunder || speechbubbleData.positionrightunder)
                        Toggle(isOn: $speechbubbleData.positionlefttop) {
                            Text("吹き出し左上 : \(speechbubbleData.positionlefttop ? "ON" : "OFF")")
                                .font(.headline)
                        }.disabled(speechbubbleData.isOn || speechbubbleData.positionleftunder || speechbubbleData.positionrightunder)
                        Toggle(isOn: $speechbubbleData.positionleftunder) {
                            Text("吹き出し左下 : \(speechbubbleData.positionleftunder ? "ON" : "OFF")")
                                .font(.headline)
                        }.disabled(speechbubbleData.isOn || speechbubbleData.positionlefttop || speechbubbleData.positionrightunder)
                        Toggle(isOn: $speechbubbleData.positionrightunder) {
                            Text("吹き出し右下 : \(speechbubbleData.positionrightunder ? "ON" : "OFF")")
                                .font(.headline)
                        }.disabled(speechbubbleData.isOn || speechbubbleData.positionlefttop || speechbubbleData.positionleftunder)
                    }
                List {
                    Section(header: Text("初めに")
                        .font(.title)) {
                            Text("右上のペンマークを押します")
                            Text("日付をカレンダーから選択します")
                            Text("日記を書いて写真を選択します")
                            Text("お気に入りにしたい時は❤️を押します")
                            Text("お気に入りに名前を付けたい時は⭐️を押します")
                            Text("保存を押します")
                        }
                    Section(header: Text("Diary")
                        .font(.title)) {
                            Text("縦スクロールで見れます")
                            Text("設定画面で文字の色を変更できます")
                        }
                    Section(header: Text("List")
                        .font(.title)) {
                            Text("日記を文字で検索できます")
                            Text("お気に入りボタンで絞り込みできます")
                            Text("名前を付けたお気に入りで絞り込みできます")
                            Text("タップで日記の表示、非表示ができます")
                            Text("長押しで編集、削除ができます")
                            Text("左スワイプでも削除できます")
                        }
                    
                    Section(header: Text("Album")
                        .font(.title)) {
                            Text("写真アルバムです")
                            Text("⭐️アルバムを開くと左上のペンマークで名前を付ける事ができます")
                            Text("写真をページ送りで表示できます。")
                            Text("タップするとスクロールタブを表示できます。")
                            Text("下スワイプで一覧画面に戻れます。")
                            Text("文字を長押しで非表示にできます。")
                        }
                    Section(header: Text("写真ズーム")
                        .font(.title)) {
                            Text("ピンチインで写真を拡大できます")
                        }
                    Section(header: Text("注意！")
                        .font(.title)
                        .foregroundColor(.red)) {
                            Text("日記を削除すると元には戻せません！")
                                .font(.headline)
                                .foregroundColor(.red)
                            Text("アプリを削除するとデータも消えます！")
                                .font(.headline)
                                .foregroundColor(.red)
                        }
                }
                
                Link(weblist.name, destination: URL(string: weblist.url)!)
                
                NavigationLink(destination: PrivacyView()) {
                    Text("プライバシーポリシー")
                }
                NavigationLink(destination: Terms_Of_ServiceView()) {
                    Text("利用規約")
                }
            }
            .navigationTitle(Text("Setting"))
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(ColorData())
            .environmentObject(RotationData())
            .environmentObject(SpeechbubbleData())
    }
}
