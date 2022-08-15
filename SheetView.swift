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
    @Environment(\.managedObjectContext)
    private var context
    @State private var isPicking: Bool = false
    @State private var images: [Data] = []
    @FocusState var focus: Bool
    
    var pickerConfig: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 1
        return config
    }
    
    var body: some View {
        VStack(alignment:.center) {
            DatePicker("日付",selection:$sampleModel.date)
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
                Spacer()
                Button("追加", action:{
                    sampleModel.writeData(context:context)
                })
                .disabled(sampleModel.text.isEmpty)
            }
            TextEditor(text: $sampleModel.text)
                .frame(width: 300, height: 250)
                .border(Color.gray)
                .lineSpacing(5)
                .padding()
                .focused(self.$focus)
            
            HStack {
            Button(action: {
                self.isPicking.toggle()
            }) {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Text("PHOTO")
            }
//            .padding()
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
                          UIImage(systemName: "person.crop.artframe")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90, alignment: .center)
                    .clipped()
                    .opacity(0.5)
                    Spacer()
                    
//                    Image(uiImage: UIImage(data: sampleModel.image2) ??
//                          UIImage(systemName: "person.crop.artframe")!)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 90, height: 90, alignment: .center)
//                    .clipped()
//                    .opacity(0.5)
//                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(sampleModel:SampleModel())
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
    }
}
