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
    @State private var isShowDetail: Bool = false

    var body: some View {
        if samples.image1?.count ?? 0
            != 0 {
            Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                .resizable()
                .frame(width: 60, height: 60)
                .overlay(Rectangle().stroke(Color.black))
            
                .onTapGesture {
                                        var transaction = Transaction()
                                        transaction.disablesAnimations = true
                                        withTransaction(transaction) {
                    isShowDetail = true
                                        }
                }
                .fullScreenCover(isPresented: $isShowDetail) {
                    FullPhotoView(samples: samples)
                    //            }
                    //                }
                
            }
        }
//              else {
//                Text(samples.wrappedText)
//                    .lineLimit(1)
//                    .frame(width: 60, height: 60)
//        }
    }
}
