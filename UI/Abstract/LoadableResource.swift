//
//  LoadableResource.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import Foundation

public enum LoadableResource<Resource> {
    case
        idle,
        loading(percentageLoaded: Int),
        loaded(Resource),
        failed(message: String)
}
