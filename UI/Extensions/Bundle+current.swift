//
//  Bundle+current.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import Foundation

extension Bundle {
    private class BundleIdentifyingDummy {}
    
    static var current: Bundle {
        Bundle(for: BundleIdentifyingDummy.self)
    }
}
