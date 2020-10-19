//
//  LiveSurfaceImageProvider.swift
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
    
    private let baseURLComponents = URLComponents(string: "https://www.livesurface.com")
    
    private var imageLoadingToken: Cancellable?
    
    init(imageName: String) {
        //extract that logic to load(imageNamed:)
        if let image = cache.object(forKey: imageName as NSString) {
            self.image = LoadableResource(loaded: image)
        }
        
        var components = baseURLComponents
        components?.path += "/test/images/" + imageName
        
        guard let url = components?.url else {
            image = .failed
            return
        }
        
        imageLoadingToken = URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .map(UIImage.init)
            .replaceError(with: nil)
            .map { $0.map(LoadableResource.init) ?? .failed }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else {
                    return
                }
                
                self.image = image
                
                if let downloadedImage = image.resource {
                    cache.setObject(downloadedImage, forKey: imageName as NSString)
                    self.originalLoaded(downloadedImage)
                }
                
                self.imageLoadingToken = nil
            }
    }
    
    func originalLoaded(_ image: UIImage) {
    }
}
