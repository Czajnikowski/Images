//
//  LoadableResource+convenience.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import UI

extension LoadableResource {
    init(loaded resource: Resource) {
        self = .loaded(resource)
    }
    
    var image: Resource? {
        if case let LoadableResource.loaded(resource) = self {
            return resource
        }
        
        return nil
    }
}
