//
//  MockTransformedImageProvider.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import UIKit

class MockTransformedImageProvider: TransformedImageProviding {
    @Published var isTransformed: Bool = false {
        didSet {
            print(isTransformed)
        }
    }
    
    let image: LoadableResource<UIImage>
    
    init(image: LoadableResource<UIImage>) {
        self.image = image
    }
}
