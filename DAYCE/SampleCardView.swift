//
//  SampleCardView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/07/30.
//

import SwiftUI

struct SampleCardView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var sampleModel: SampleModel
    @ObservedObject var samples: SampleData
    @State private var isShowDetail: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                Text(samples.wrappedDate,
                     formatter: itemFormatter)
                Spacer()
                
                Text(samples.wrappedText)
                    .lineLimit(1)
                    .frame(width: 100)
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
            if samples.bool {
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
            }
            if samples.bool2 {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            Spacer()
            if samples.image1?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 1)
                    }
                    .shadow(radius: 7)
            }
            if samples.image2?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg2)!)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "y年M月d日"
        formatter.string(from: Date())
        return formatter
    }()
}
