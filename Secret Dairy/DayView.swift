//
//  DayView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/21.
//

import SwiftUI

struct DayView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData
    @ObservedObject var sampleModel: SampleModel
    @State private var min: CGFloat = 1.0
    @State private var max: CGFloat = 3.0
    @State var currentScale: CGFloat = 1.0
//    @State var isShowDetail: Bool = false
    
    var body: some View {
//        if samples.image1?.count ?? 0
//                != 0 {
//                ZoomableScrollView{
                    if samples.image1?.count ?? 0
                        != 0 {
                        ZoomableScrollView{
                        Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //                          .frame(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                        //                        .ignoresSafeArea()
                    }
                        .edgesIgnoringSafeArea(.all)
                }
//                .navigationBarTitleDisplayMode(.inline)
//                .edgesIgnoringSafeArea(.all)
//                .onTapGesture {
//                    var transaction = Transaction()
//                    transaction.disablesAnimations = true
//                    withTransaction(transaction) {
//                        self.isShowDetail = true
//                    }
//                }
//                .fullScreenCover(isPresented: $isShowDetail) {
//                        FullPhotoView(samples: samples, isShowDetail: $isShowDetail)
                    //            }
//        }
    }
}

