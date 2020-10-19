//
//  MockImagesViewModel.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import Foundation

class MockImagesViewModel: ImagesViewModelProtocol {
    @Published var elements: LoadableResource<[ImageElementState<MockImageProvider>]> = .idle
    
    func loadElements() {
        elements = .loaded([
            (0, MockImageProvider(image: .loading(percentageLoaded: 22)), "some"),
            (1, MockImageProvider(image: .loaded(.mocked)), "thing"),
            (2, MockImageProvider(image: .failed(message: "Failed")), "else?")
        ].map(ImageElementState.init))
    }
}
