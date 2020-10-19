//
//  DecodedValueProviding.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Combine
import Foundation

protocol DecodedValueProviding {
    func provide<Value>(
        _ valueType: Value.Type,
        for url: URL
    ) -> (AnyPublisher<Value, Error>, AnyPublisher<Int, Never>) where Value : Decodable
}
