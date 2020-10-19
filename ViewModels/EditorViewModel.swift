//
//  EditorViewModel.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Foundation
import UI

class EditorViewModel: EditorViewModelProtocol {
    let name: String
    let transformedImageProvider: TransformedImageProvider
    
    init(imageDTO: ImageDTO) {
        name = imageDTO.name
        transformedImageProvider = TransformedImageProvider(imageName: imageDTO.image)
    }
}
