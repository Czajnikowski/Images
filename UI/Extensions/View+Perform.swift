//
//  View+Perform.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

extension View {
    func Perform(_ block: () -> Void) -> some View {
        block()
        return EmptyView()
    }
}
