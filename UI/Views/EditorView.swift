//
//  EditorView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

public class EditorBuilder {
    public static func buildView<ViewModel>(
        viewModel: ViewModel
    ) -> some View where ViewModel: EditorViewModelProtocol {
        EditorView(viewModel: viewModel)
    }
}

public protocol EditorViewModelProtocol {
    associatedtype ImageProvider: ImageProviding
    
    var imageProvider: ImageProvider { get }
    var name: String { get }
}

struct EditorView<ViewModel>: View where ViewModel: EditorViewModelProtocol {
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.name = viewModel.name
    }
    
    let name: String
    
    var body: some View {
        ImageCellView(
            imageProvider: viewModel.imageProvider,
            name: name
        )
    }
}

