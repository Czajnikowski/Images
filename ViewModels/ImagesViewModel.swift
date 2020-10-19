//
//  ImagesViewModel.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Foundation
import UI
import Combine

import UIKit
class MockImageProvider: ImageProviding {
    let image: LoadableResource<UIImage>
    
    init(image: LoadableResource<UIImage>) {
        self.image = image
    }
}

class ImagesViewModel: ImagesViewModelProtocol {
    let service: DecodedValueProviding
    
    var elements: LoadableResource<[ImageElementState<MockImageProvider>]> = .idle
    @Published private var imageDTOs: [ImageDTO] = [] {
        didSet {
            elements = .loaded(
                imageDTOs.map {
                    ImageElementState(
                        id: $0.index,
                        imageProvider: MockImageProvider(image: .loading(percentageLoaded: 33)),
                        name: $0.name
                    )
                }
            )
        }
    }
    
    private var elementsLoadingToken: Cancellable?
    
    init(service: DecodedValueProviding) {
        self.service = service
    }
    
    func loadElements() {
        elementsLoadingToken = service.provideImageDTOs()
            .catch { error -> AnyPublisher<[ImageDTO], Never> in
                DispatchQueue.main.async {
                    self.elements = .failed(message: error.localizedDescription)
                }
                
                return Empty(completeImmediately: true)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.imageDTOs, on: self)
    }
}
