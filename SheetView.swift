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
    
    var pickerConfig: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 2
        return config
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            
            DatePicker("",selection:$sampleModel.date)
                
                .datePickerStyle(GraphicalDatePickerStyle())
                .environment(\.locale, Locale(identifier: "ja_JP"))
                .ignoresSafeArea()
            
            HStack {
                Button("戻る", action:{
                    sampleModel.isNewData = false
                })
                .foregroundColor(.blue)
                Spacer()
                
                
                Button(action:{
                               sampleModel.bool.toggle()}){
                                   Image(systemName:sampleModel.bool ? "star.fill":"star")
                               }
                Spacer()
                Button("追加", action:{
                    sampleModel.writeData(context:context)
                })
                .foregroundColor(.blue)
            }
            
            TextField("出来事を書いて下さい", text:$sampleModel.text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
            Button(action: {
                self.isPicking.toggle()
            }) {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                Text("PHOTO")
            }
            .padding()
            
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
                .frame(width: 100, height: 100, alignment: .center)
                .border(Color.gray)
                .clipped()
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
                .frame(width: 100, height: 100, alignment: .center)
                .border(Color.gray)
                .clipped()
                
                Image(uiImage: UIImage(data: images[1]) ??
                      UIImage(systemName: "photo")!)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100, alignment: .center)
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
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
                    .opacity(0.5)
                    Spacer()
                    
                    Image(uiImage: UIImage(data: sampleModel.image2) ??
                          UIImage(systemName: "person.crop.artframe")!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
                    .opacity(0.5)
                    Spacer()
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
