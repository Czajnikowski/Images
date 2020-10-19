//
//  ImagesDTO.swift
//  API
//
//  Created by Maciek on 19/10/2020.
//

import Foundation

public struct ImagesDTO: Decodable {
    public let images: [String: ImageDTO]
}
