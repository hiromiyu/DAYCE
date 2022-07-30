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
                    .scaledToFill()
                    .frame(width: 75, height: 75, alignment: .center)
                    .clipped()
                    .padding(.leading)
            }
            if samples.image2?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg2)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75, alignment: .center)
                    .clipped()
            }
                Spacer()
            
            VStack {
                Text(samples.wrappedDate,
                formatter: itemFormatter)
                
                Text(samples.wrappedText)
            Image(systemName: samples.bool ? "star.fill":"star")
            }
        .frame(minWidth:UIScreen.main.bounds.size.width * 0.3,
               maxWidth:UIScreen.main.bounds.size.width * 0.8,
               minHeight:UIScreen.main.bounds.size.height * 0.2,
               maxHeight:UIScreen.main.bounds.size.height * 0.7
        )
        
        .contextMenu{
            Button(action: {
                sampleModel.editItem(item:samples)
            }){
                Image(systemName: "pencil")
                    .foregroundColor(Color.blue)
            }
            Button(action: {
                context.delete(samples)
                try!
                context.save()
            }){
                Image(systemName: "trash")
                    .foregroundColor(Color.blue)
                }
            }
            Spacer()
        }
    }
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ja_JA")
        formatter.dateStyle = .medium
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
