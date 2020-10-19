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

//todo
class LiveSurfaceImageProvider: ImageProviding {
    @Published var image: LoadableResource<UIImage> = .idle
    
    //force
    private let baseURLComponents = URLComponents(string: "https://www.livesurface.com")!
    
    private var imageLoadingToken: Cancellable?
    
    init(imageName: String) {
        //extract that logic to load(imageNamed:)
        if let image = cache.object(forKey: imageName as NSString) {
            self.image = LoadableResource(loaded: image)
        }
        
        var components = baseURLComponents
        components.path += "/test/images/" + imageName
        
        imageLoadingToken = URLSession
            .shared
            //force
            .dataTaskPublisher(for: components.url!)
            .map(\.data)
            .map(UIImage.init)
            .replaceError(with: nil)
            //local?
            .map { $0.map(LoadableResource.init) ?? .failed(message: "Unable to display image") }
            .receive(on: DispatchQueue.main)
            .sink { image in
                //weak self?
                if let downloadedImage = image.image {
                    cache.setObject(downloadedImage, forKey: imageName as NSString)
                }
                
                self.image = image
                //tmp
                image.image.map(self.originalLoaded)
                self.imageLoadingToken = nil
            }
    }
    
    func originalLoaded(_ image: UIImage) {
    }
}
