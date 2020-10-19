//
//  MockEditorViewModel.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import Foundation

class MockEditorViewModel: EditorViewModelProtocol {
    let name: String = ""
    
    let transformedImageProvider = MockTransformedImageProvider(image: .failed)   
}
