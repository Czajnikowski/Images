//
//  ImageCellView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

public protocol ImageProviding: ObservableObject {
    var image: LoadableResource<UIImage> { get }
}

public enum LoadableResource<Resource> {
    case
        loading(percentageLoaded: Int),
        loaded(Resource),
        failed(message: String)
}

struct ImageCellView<ImageProvider>: View where ImageProvider: ImageProviding {
    @StateObject var imageProvider: ImageProvider
    
    let name: String
    
    var body: some View {
        VStack {
            switch imageProvider.image {
            case let .loading(percentageLoaded):
                Text("Loading: \(percentageLoaded)")
            case let .loaded(image):
                Image(uiImage: image)
            case let .failed(message):
                Text("Error: \(message)")
            }
            Text(name)
        }
    }
}

struct ImageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCellView(
            imageProvider: MockImageProvider(image: .loading(percentageLoaded: 95)),
            name: "Some name"
        )
    }
}

class MockImageProvider: ImageProviding {
    let image: LoadableResource<UIImage>
    
    init(image: LoadableResource<UIImage>) {
        self.image = image
    }
}
