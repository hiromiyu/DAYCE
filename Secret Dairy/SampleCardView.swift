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
    
    var body: some View {
        HStack {
            if samples.image1?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                   // .scaledToFill()
                    .frame(width: 50, height: 50)
                    //.clipped()
                    //.padding(.leading)
            }
            if samples.image2?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg2)!)
                    .resizable()
                    //.scaledToFill()
                    .frame(width: 50, height: 50)
                    //.clipped()
            }

            VStack {
                Text(samples.wrappedDate,
                formatter: itemFormatter)
                
                Text(samples.wrappedText)
                    .lineLimit(1)
                    .frame(width: 100)
                
            Image(systemName: samples.bool ? "star.fill":"star")
            }
        .contextMenu{
            Button(action: {
                sampleModel.editItem(item:samples)
            }){
                Text("編集")
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color.blue)
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
            Spacer()
        }
    }
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}

struct SampleCardView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
