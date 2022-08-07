//
//  HorizontalView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/07.
//

import SwiftUI

struct HorizontalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var sampleModel = SampleModel()

    @FetchRequest(
        entity:SampleData.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleData.date, ascending: false)],
        animation: .default)
    private var samples: FetchedResults<SampleData>
    
    var body: some View {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 10) {
                    ForEach(samples) { i in
                        PhotoView(samples: i)
                }
            }
        }
    }
}
