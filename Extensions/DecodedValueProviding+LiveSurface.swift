//
//  DecodedValueProviding+LiveSurface.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Combine
import Foundation

extension String: Error {}

extension DecodedValueProviding {
    private var url: URL? {
        URL(string: "https://www.livesurface.com/test/api/images.php?key=79319da5-8cb3-43ac-f5b0-f38a727242a8&pro=1")
    }
    
    func provideImageDTOs() -> (
        imageDTOs: AnyPublisher<[ImageDTO], String>,
        progress: AnyPublisher<Int, Never>
    ) {
        guard let url = url else {
            return (
                Fail(error: "No URL").eraseToAnyPublisher(),
                Empty(completeImmediately: true).eraseToAnyPublisher()
            )
        }
        
        let publishers = provide(ImagesDTO.self, for: url)
        
        return (
            publishers
                .value
                .mapError { $0.localizedDescription }
                .map(\.images)
                .map(\.values)
                .map(Array.init)
                .eraseToAnyPublisher(),
            publishers
                .progress
        )
    }
}
