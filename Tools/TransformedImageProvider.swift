//
//  TransformedImageProvider.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import UI
import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class TransformedImageProvider: LiveSurfaceImageProvider {
    @Published var isTransformed: Bool = false {
        didSet {
            if isTransformed {
                guard let inputImage = originalImage.flatMap(CIImage.init) else {
                    return
                }
                
                let ciFilter = CIFilter.falseColor()
                ciFilter.inputImage = inputImage
                
                image = .loaded(
                    UIImage(
                        cgImage: CIContext().createCGImage(
                            ciFilter.outputImage!,
                            from: ciFilter.outputImage!.extent
                        )!
                    )
                )
            }
            else {
                if let originalImage = originalImage {
                    self.image = .loaded(originalImage)
                }
                else {
                    self.image = .idle
                }
            }
        }
    }
    
    @Published private var originalImage: UIImage?
    
    override func originalLoaded(_ image: UIImage) {
        originalImage = image
    }
}

extension TransformedImageProvider: TransformedImageProviding {
}
