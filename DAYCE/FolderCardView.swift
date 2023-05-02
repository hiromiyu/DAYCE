//
//  FolderCardView.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/02.
//

import SwiftUI

struct FolderCardView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples: SampleData
    @ObservedObject var sampleModel: SampleModel
    
    var body: some View {
        VStack {
            if samples.image1?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)
            }
        }
        .contextMenu{
            Button(action: {
                sampleModel.editItem(item:samples)
            }){
                Text("編集")
                Image(systemName: "square.and.pencil")
            }
            Button(role: .destructive, action: {
                context.delete(samples)
                try!
                context.save()
            }){
                Text("削除")
                Image(systemName: "trash")
            }
        }
    }
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }()
}
