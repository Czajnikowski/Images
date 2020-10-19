//
//  View+any.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

extension View {
    var asAny: AnyView {
        AnyView(self)
    }
}
