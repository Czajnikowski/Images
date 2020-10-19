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
    associatedtype TransformedImageProvider: TransformedImageProviding
    
    var transformedImageProvider: TransformedImageProvider { get }
    var name: String { get }
}

public protocol TransformedImageProviding: ImageProviding {
    var isTransformed: Bool { get set }
}

struct EditorView<ViewModel>: View where ViewModel: EditorViewModelProtocol {
    private let viewModel: ViewModel
    
    @ObservedObject private var transformedImageProvider: ViewModel.TransformedImageProvider
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.transformedImageProvider = viewModel.transformedImageProvider
        self.name = viewModel.name
    }
    
    let name: String
    
    var body: some View {
        VStack {
            ImageCellView(
                imageProvider: viewModel.transformedImageProvider,
                name: name
            )
            Toggle(
                "Transform",
                isOn: $transformedImageProvider.isTransformed
            )
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
