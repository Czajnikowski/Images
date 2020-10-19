//
//  ImagesViewModel.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Foundation
import UI
import Combine

class ImagesViewModel: ImagesViewModelProtocol {
    typealias Element = ImageElementState<LiveSurfaceImageProvider>
    let service: DecodedValueProviding
    
    @Published var elements: LoadableResource<[Element]> = .idle
    private var imageDTOs: [ImageDTO] = [] {
        didSet {
            elements = .loaded(
                imageDTOs.map {
                    ImageElementState(
                        id: $0.index,
                        imageProvider: LiveSurfaceImageProvider(imageName: $0.image),
                        name: $0.name
                    )
                }
            )
        }
    }
    
    private var elementsLoadingToken: Cancellable?
    private var elementsLoadingProgressToken: Cancellable?
    
    init(service: DecodedValueProviding) {
        self.service = service
    }
    
    func loadElements() {
        elements = .loading(percentageLoaded: 0)
        
        let publishers = service.provideImageDTOs()
        
        elementsLoadingToken = publishers
            .imageDTOs
            .catch { error -> AnyPublisher<[ImageDTO], Never> in
                DispatchQueue.main.async {
                    self.elements = .failed
                }
                
                return Empty(completeImmediately: true)
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.imageDTOs, on: self)
        
        elementsLoadingProgressToken = publishers
            .progress
            .map { LoadableResource<[Element]>.loading(percentageLoaded: $0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.elements, on: self)
    }
    
    func imageDTO(
        forElementWithID elementID: Element.ID
    ) -> ImageDTO? {
        return imageDTOs.first(where: { $0.index == elementID })
    }
}
