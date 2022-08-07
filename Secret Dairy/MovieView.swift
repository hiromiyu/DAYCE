//
//  MovieView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/07.
//

import SwiftUI

struct MovieView: View {
    @State private var movieUrl: URL?
    @State private var showPhotoLibraryMoviePickerView = false
    @State private var showMoviePlayerView = false
    private var canPlayVideo: Bool {
        movieUrl != nil
    }
    
    var body: some View {
        VStack {
            Button {
                showPhotoLibraryMoviePickerView = true
            } label: {
                Text("Photo Library Movie Picker")
            }
            Button {
                showMoviePlayerView = true
                guard let url = movieUrl else {
                    return
                }
                print(url)
            } label: {
                Image(systemName: "play")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(canPlayVideo ? .accentColor : .gray)
            }
            .disabled(!canPlayVideo)
        }
        .fullScreenCover(isPresented: $showPhotoLibraryMoviePickerView) {
            PhotoLibraryMoviePickerView(movieUrl: $movieUrl)
        }
        .fullScreenCover(isPresented: $showMoviePlayerView) {
            MoviePlayerView(with: movieUrl)
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
