//
//  SheetView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/07/30.
//

import SwiftUI
import PhotosUI

struct SheetView: View {
    @ObservedObject var sampleModel: SampleModel
    @EnvironmentObject var albumName: AlbumName
    @Environment(\.managedObjectContext)
    private var context
    @State private var isPicking: Bool = false
    @State private var images: [Data] = []
    @State var istltle = false
    @FocusState var focus: Bool
    
    var pickerConfig: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 1
        return config
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                DatePicker("日付",selection:$sampleModel.date, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                HStack {
                    Button("戻る", action:{
                        sampleModel.isNewData = false
                    })
                    Spacer()
                    Button(action:{
                        sampleModel.bool.toggle()}){
                            Image(systemName:sampleModel.bool ? "heart.fill":"heart")
                                .foregroundColor(.pink)
                        }
                        .disabled(sampleModel.bool2)
                    Button(action:{
                        sampleModel.bool2.toggle()
                        istltle = true
                    }){
                            Image(systemName:sampleModel.bool2 ? "star.fill":"star")
                                .foregroundColor(.yellow)
                        }
                        .disabled(sampleModel.bool)
                    Spacer()
                    Button("保存", action:{
                        sampleModel.writeData(context:context)
                    })
                    .disabled(sampleModel.text.isEmpty && sampleModel.image1.isEmpty)
                }
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $sampleModel.text)
                        .lineSpacing(5)
                        .focused(self.$focus)
                    if sampleModel.text.isEmpty {
                        Text("ここに文字を入力してください。")
                            .foregroundColor(Color(uiColor: .placeholderText))
                            .allowsHitTesting(false)
                            .padding(10.0)
                    }
                }
                HStack {
                    Button(action: {
                        self.isPicking.toggle()
                    }) {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("写真")
                            .font(.headline)
                    }
                    Spacer()
                    if self.focus {
                        Button("キーボードを閉じる"){
                            self.focus = false
                        }
                    }
                }
                .fullScreenCover(isPresented: $isPicking) {
                    ImagePicker(
                        configuration: pickerConfig,
                        completion: { result in },
                        isPicking:$isPicking,
                        images: $images)
                }
                switch images.count {
                case 1: HStack {
                    Image(uiImage: UIImage(data: images[0]) ??
                          UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90, alignment: .center)
                    .border(Color.gray)
                    .clipped()
                    .cornerRadius(10)
                    Spacer()
                }
                .onAppear(){
                    sampleModel.image1 = images[0]
                    sampleModel.image2 = Data.init()
                }
                case 2: HStack {
                    Image(uiImage: UIImage(data: images[0]) ??
                          UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90, alignment: .center)
                    .border(Color.gray)
                    .clipped()
                    
                    Image(uiImage: UIImage(data: images[1]) ??
                          UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90, alignment: .center)
                    .border(Color.gray)
                    .clipped()
                }
                .onAppear(){
                    sampleModel.image1 = images[0]
                    sampleModel.image2 = images[1]
                }
                default:
                    HStack {
                        Image(uiImage: UIImage(data: sampleModel.image1) ??
                              UIImage(systemName: "photo")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90, alignment: .center)
                        .clipped()
                        .opacity(0.5)
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(sampleModel:SampleModel())
            .environmentObject(AlbumName())
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
            .previewInterfaceOrientation(.portrait)
    }
}
