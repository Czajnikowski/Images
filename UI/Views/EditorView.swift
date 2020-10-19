//
//  EditorView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

struct EditorView<ImageProvider>: View where ImageProvider: ImageProviding {
    @StateObject var imageProvider: ImageProvider
    
    let name: String
    
    var body: some View {
        ImageCellView(
            imageProvider: imageProvider,
            name: name
        )
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(
            imageProvider: MockImageProvider(image: .loaded(.mocked)),
            name: "Yeah"
        )
    }
}
