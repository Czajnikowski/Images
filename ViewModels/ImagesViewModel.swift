//
//  ImagesViewModel.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Foundation
import UI

class ImagesViewModel: ImagesViewModelProtocol {
    var elements: LoadableResource<[ImageElementState<ImageProvider>]> = .idle
    func loadElements() {
    }
}
