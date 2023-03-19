//
//  FavoritesPager.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/22.
//

import SwiftUI

struct FavoritesPager: View {
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
    @State private var showFavoritesOnly = true

    var filteredsamples: [SampleData] {
        sampleis.filter { sample in
            (!showFavoritesOnly || sample.bool)
        }
    }
    
    var body: some View {
        ZStack {
            SwipeReader {
                TabView(selection: $selectedTag) {
                    ForEach(filteredsamples.indices, id: \.self) { item in
                        ZoomView(samples: filteredsamples[item])
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
                Spacer()
            }
            }
            if emptySwitchON {
                EmptyView()
            } else {
                VStack {
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { proxy in
                            HStack {
                                ForEach(filteredsamples.indices, id: \.self) { item in
                                    Button(action: {
                                        withAnimation {
                                            selectedTag = item
                                        }
                                    }, label: {
                                        ScrollTabView(samples: filteredsamples[item], sampleModel: sampleModel)
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

struct FavoritesPager_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesPager(samples: SampleData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
