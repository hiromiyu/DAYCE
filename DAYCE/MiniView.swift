//
//  MiniView.swift
//  DAYCE
//
//  Created by ひろ on 2023/04/28.
//

import SwiftUI

struct MiniView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples: SampleData
    @ObservedObject var sampleModel: SampleModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack(alignment: .top) {
                ZStack {
                    Text(samples.wrappedDate,
                         formatter: itemFormatter)
                    Circle()
                        .frame(width: 70, height: 70)
                        .opacity(0.5)
                }
                VStack {
                    Text(samples.wrappedText)
                    if samples.image1?.count ?? 0
                        != 0 {
                            Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                    }
                }
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
        formatter.dateFormat = "M月d日"
        return formatter
    }()
}
