//
//  ImageProvider.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import UIKit
import UI
import Combine

class LiveSurfaceImageProvider: ImageProviding {
    @Published var image: LoadableResource<UIImage> = .idle
    
    private let baseURLComponents = URLComponents(string: "https://www.livesurface.com")!
    
    private var imageLoadingToken: Cancellable?
    
    init(imageName: String) {
        var components = baseURLComponents
        components.path += "/test/images/" + imageName
        
        imageLoadingToken = URLSession
            .shared
            .dataTaskPublisher(for: components.url!)
            .map(\.data)
            .map(UIImage.init)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink {
                guard let image = $0 else {
                    return
                }
                
                self.image = .loaded(image)
                self.imageLoadingToken = nil
            }
    }
}
