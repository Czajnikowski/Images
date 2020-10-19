//
//  ImageCellView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

struct ImageCellView<ImageProvider>: View where ImageProvider: ImageProviding {
    #if targetEnvironment(macCatalyst)
    @ObservedObject var imageProvider: ImageProvider
    #else
    @StateObject var imageProvider: ImageProvider
    #endif
    
    let name: String
    
    var body: some View {
        VStack {
            switch imageProvider.image {
            case .idle:
                Text("Idle")
            case let .loading(percentageLoaded):
                Text("Loading: \(percentageLoaded)")
            case let .loaded(image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            case .failed:
                Text("Failed")
            }
            Text(name)
        }
    }
}

struct ImageCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ImageCellView(
                imageProvider: MockImageProvider(image: .loading(percentageLoaded: 95)),
                name: "Some name"
            )
            ImageCellView(
                imageProvider: MockImageProvider(image: .loaded(.mocked)),
                name: "Some name2"
            )
        }
    }
}
