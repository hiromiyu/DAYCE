//
//  FullPhotoView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/10/08.
//

import SwiftUI

struct FullPhotoView: View {
    @Environment(\.managedObjectContext)
    private var context
    @ObservedObject var samples : SampleData
    @State private var min: CGFloat = 1.0
    @State private var max: CGFloat = 3.0
    @State var currentScale: CGFloat = 1.0
//    @State var isShowDetail: Bool
    @Environment(\.dismiss) private var dismiss
//    @State var opacity: Double = 0
   
                   

    var body: some View {
        if samples.image1?.count ?? 0
            != 0 {
            ZoomableScrollView{
                Image(uiImage: UIImage(data: samples.wrappedImg1)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //                          .frame(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            }
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.all)
            .statusBarHidden()
            .onTapGesture {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                dismiss()
                    }
                }
            .transaction({ transaction in
                transaction.disablesAnimations = true
            })
        }
    }
}
