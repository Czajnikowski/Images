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
    private var url: URL {
        URL(string: "https://www.livesurface.com/test/api/images.php?key=79319da5-8cb3-43ac-f5b0-f38a727242a8")!
    }
    
    func provideImageDTOs() -> AnyPublisher<[ImageDTO], String> {
        provide(ImagesDTO.self, for: url)
            .mapError { $0.localizedDescription }
            .map(\.images)
            .map { Array($0.values) }
            .eraseToAnyPublisher()
    }
}
