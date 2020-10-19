//
//  ImageProviding.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

public protocol ImageProviding: ObservableObject {
    var image: LoadableResource<UIImage> { get }
}
