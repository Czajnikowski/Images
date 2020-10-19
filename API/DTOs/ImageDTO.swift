//
//  ImageDTO.swift
//  API
//
//  Created by Maciek on 19/10/2020.
//

import Foundation

public struct ImageDTO: Decodable {
    public let index: Int
    public let name: String
    public let image: String
}
