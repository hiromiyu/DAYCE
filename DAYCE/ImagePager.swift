//
//  ImagePager.swift
//  DAYCE
//
//  Created by ひろ on 2022/12/14.
//

import SwiftUI

struct ImagePager: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()
    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var sampleis: FetchedResults<SampleData>
    @ObservedObject var samples : SampleData
    @State var selectedTag = 0
    @State var emptySwitchON = true
    @State var isLink = false
    @Environment(\.dismiss) private var dismiss
    @State private var isTapped = false
    
    var body: some View {
        ZStack {
            SwipeReader {
                TabView(selection: $selectedTag) {
                    ForEach(sampleis.indices, id: \.self) { item in
                        ZoomView(samples: sampleis[item])
                    }
                }
            }
            .onSwipe(.down, action: {
                dismiss()
            })
            .navigationBarBackButtonHidden()
            .edgesIgnoringSafeArea(.all)
            .statusBarHidden()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onTapGesture {
                emptySwitchON.toggle()
            }
            if emptySwitchON {
                EmptyView()
            } else {
                VStack {
                    ZStack(alignment: .topTrailing) {
                        HStack {
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Text("閉じる")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .padding([.top, .trailing])
                            }
                        }
                    }
                    Spacer()
                }
                if emptySwitchON {
                    EmptyView()
                } else {
                    VStack {
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                HStack {
                                    ForEach(sampleis.indices, id: \.self) { item in
                                        Button(action: {
                                            withAnimation {
                                                selectedTag = item
                                            }
                                        }, label: {
                                            ScrollTabView(samples: sampleis[item], sampleModel: sampleModel)
                                        })
                                    }
                                    .onAppear(perform: {
                                        proxy.scrollTo(selectedTag, anchor: .center)
                                    })
                                }
                                .padding([.leading, .bottom, .trailing])
                                .onChange(of: selectedTag, perform: { index in
                                    withAnimation {
                                        proxy.scrollTo(index, anchor: .center)
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}
struct ImagePager_Previews: PreviewProvider {
    static var previews: some View {
        ImagePager(samples: SampleData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
