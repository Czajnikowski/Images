//
//  URLSessionDecodeedValueProvider.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Foundation
import Combine

class URLSessionDecodeedValueProvider: DecodedValueProviding {
    func provide<Value>(
        _ valueType: Value.Type,
        for url: URL
    ) -> AnyPublisher<Value, Error> where Value : Decodable {
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Value.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
