//
//  URLSessionDecodeedValueProvider.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import Foundation
import Combine

class URLSessionDecodeedValueProvider: DecodedValueProviding {
    private var progressObservation: NSKeyValueObservation?
    
    func provide<Value>(
        _ valueType: Value.Type,
        for url: URL
    ) -> (AnyPublisher<Value, Error>, AnyPublisher<Int, Never>) where Value: Decodable {
        let dataSubject = PassthroughSubject<Data, Error>()
        
        let task = URLSession
            .shared
            .dataTask(with: url) { data, _, error in
                if let error = error {
                    dataSubject.send(completion: .failure(error))
                }
                dataSubject.send(data!)
            }
        
        let progressSubject = PassthroughSubject<Int, Never>()
        
        progressObservation = task.progress.observe(\.fractionCompleted) { progress, fractionCompleted in
            progressSubject.send(Int((progress.fractionCompleted)) * 100)
        }
        task.resume()
            
        return (
            dataSubject
                .decode(type: Value.self, decoder: JSONDecoder())
                .eraseToAnyPublisher(),
            progressSubject.eraseToAnyPublisher()
        )
    }
}
