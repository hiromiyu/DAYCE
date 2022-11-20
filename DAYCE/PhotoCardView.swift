//
//  PhotoCardView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/03.
//

import SwiftUI

struct PhotoCardView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples: SampleData
    @ObservedObject var sampleModel: SampleModel
    @State var isShowDetail: Bool = false

    var body: some View {
            if samples.image1?.count ?? 0
                != 0 {
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipped()
                    .overlay(Rectangle().stroke(Color.black))
                    .onTapGesture {
                                                            var transaction = Transaction()
                                                            transaction.disablesAnimations = true
                                                            withTransaction(transaction) {
                                                                    isShowDetail.toggle()
                                                                }
                    }
                    .fullScreenCover(isPresented: $isShowDetail) {
                        FullPhotoView(samples: samples)
                    }
                    .transaction({ transaction in
                        transaction.disablesAnimations = true
                    })
            }
    }
}
