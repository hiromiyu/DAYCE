//
//  test.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/12.
//

import SwiftUI

struct test: View {
    var body: some View {
        ImageViewer(imageName: "sa")
            .ignoresSafeArea(.all, edges: .all)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
