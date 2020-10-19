//
//  MockImageProvider.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import UIKit

class MockImageProvider: ImageProviding {
    let image: LoadableResource<UIImage>
    
    init(image: LoadableResource<UIImage>) {
        self.image = image
    }
}
