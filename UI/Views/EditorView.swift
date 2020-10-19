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
    
    @State private var isTransformed = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.name = viewModel.name
    }
    
    let name: String
    
    var body: some View {
        VStack {
            ImageCellView(
                imageProvider: viewModel.imageProvider,
                name: name
            )
            Toggle("Transform", isOn: $isTransformed)
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView(
            viewModel: MockEditorViewModel()
        )
    }
}
