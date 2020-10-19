//
//  MockEditorViewModel.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import Foundation

class MockEditorViewModel: EditorViewModelProtocol {
    var name: String = ""
    
    var imageProvider = MockImageProvider(image: .failed(message: "failed"))
}
