//
//  ImageProvider.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import UIKit
import UI
import Combine

private let cache = NSCache<NSString, UIImage>()

class LiveSurfaceImageProvider: ImageProviding {
    @Published var image: LoadableResource<UIImage> = .idle
    
    private let baseURLComponents = URLComponents(string: "https://www.livesurface.com")!
    
    private var imageLoadingToken: Cancellable?
    
    init(imageName: String) {
        if let image = cache.object(forKey: imageName as NSString) {
            self.image = LoadableResource(loaded: image)
        }
        
        var components = baseURLComponents
        components.path += "/test/images/" + imageName
        
        imageLoadingToken = URLSession
            .shared
            .dataTaskPublisher(for: components.url!)
            .map(\.data)
            .map(UIImage.init)
            .replaceError(with: nil)
            .map { $0.map(LoadableResource.init) ?? .failed(message: "Unable to display image") }
            .receive(on: DispatchQueue.main)
            .sink { image in
                if let downloadedImage = image.image {
                    cache.setObject(downloadedImage, forKey: imageName as NSString)
                }
                
                self.image = image
                
                self.imageLoadingToken = nil
            }
    }
}
