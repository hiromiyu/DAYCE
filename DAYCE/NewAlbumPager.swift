//
//  NewAlbumPager.swift
//  DAYCE
//
//  Created by ひろ on 2023/01/22.
//

import SwiftUI

struct NewAlbumPager: View {
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
    @State private var showNewAlbumOnly = true

    var filteredAlbums: [SampleData] {
        sampleis.filter { sample in
            (!showNewAlbumOnly || sample.bool2)
        }
    }
    
    var body: some View {
        ZStack {
            SwipeReader {
                TabView(selection: $selectedTag) {
                    ForEach(filteredAlbums.indices, id: \.self) { item in
                        ZoomView(samples: filteredAlbums[item])
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
                                ForEach(filteredAlbums.indices, id: \.self) { item in
                                    Button(action: {
                                        withAnimation {
                                            selectedTag = item
                                        }
                                    }, label: {
                                        ScrollTabView(samples: filteredAlbums[item], sampleModel: sampleModel)
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

struct NewAlbumPager_Previews: PreviewProvider {
    static var previews: some View {
        NewAlbumPager(samples: SampleData())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
