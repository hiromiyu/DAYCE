//
//  ZoomView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/09/18.
//

import SwiftUI

struct ZoomView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData
    @StateObject private var sampleModel = SampleModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            Text(samples.wrappedText)
                .font(.title)
                .frame(width: 350)
            if samples.image1?.count ?? 0 != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .scaledToFit()
            }
        }
        .onTapGesture {
            var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
            dismiss()
                                        }
                                    }
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .top) {
            HStack {
                Spacer()
            }
            .overlay {
                Text(samples.wrappedDate,
                     formatter: itemFormatter)
            }
            .padding()
            .foregroundColor(.primary)
            .background(.ultraThinMaterial)
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
