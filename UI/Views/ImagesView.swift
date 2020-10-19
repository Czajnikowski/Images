//
//  ImagesView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

public class ImagesBuilder {
    public static func buildView<ViewModel, EditorViewModel>(
        viewModel: ViewModel,
        editorViewModelForElementIDProvider provideEditorViewModelForElementID: @escaping  (ImageElementState<ViewModel.ImageProvider>.ID) -> EditorViewModel?
    ) -> some View where
        ViewModel: ImagesViewModelProtocol,
        EditorViewModel: EditorViewModelProtocol
    {
        ImagesView(
            viewModel: viewModel,
            buildEditorView: {
                let viewModel = provideEditorViewModelForElementID($0)
                
                return viewModel.map(EditorBuilder.buildView)?.asAny
            }
        )
    }
}

public protocol ImagesViewModelProtocol: ObservableObject {
    associatedtype ImageProvider: ImageProviding
    
    var elements: LoadableResource<[ImageElementState<ImageProvider>]> { get }
    
    func loadElements()
}

public struct ImageElementState<ImageProvider>: Identifiable where
    ImageProvider: ImageProviding
{
    public let id: Int
    
    let imageProvider: ImageProvider
    let name: String
    
    public init(
        id: Int,
        imageProvider: ImageProvider,
        name: String
    ) {
        self.id = id
        self.imageProvider = imageProvider
        self.name = name
    }
}

struct ImagesView<ViewModel>: View where ViewModel: ImagesViewModelProtocol {
    typealias ElementID = ImageElementState<ViewModel.ImageProvider>.ID
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var columnWidth: CGFloat = 100
    @State private var showEditor = false
    @State private var selectedElementID: ElementID?
    
    let buildEditorView: (ElementID) -> AnyView?
    
    var body: some View {
        Group {
            switch viewModel.elements {
            case .idle:
                Text("Idle")
            case .loading:
                Text("Loading")
            case let .loaded(elements):
                GeometryReader { g in
                    VStack {
                        Slider(value: $columnWidth, in: 50 ... g.size.width / 2)
                        GridView(columnWidth: columnWidth) {
                            ForEach(elements) { element in
                                ImageCellView(
                                    imageProvider: element.imageProvider,
                                    name: element.name
                                )
                                    .aspectRatio(1, contentMode: .fill)
                                    .onTapGesture {
                                        selectedElementID = element.id
                                        showEditor.toggle()
                                    }
                                    .sheet(isPresented: $showEditor) {
                                        selectedElementID.map(buildEditorView)
                                            ?? Text("Something wrong").asAny
                                    }
                            }
                        }
                    }
                }
            case .failed:
                Text("Failed")
            }
        }
            .onAppear {
                viewModel.loadElements()
            }
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesBuilder.buildView(
            viewModel: MockImagesViewModel(),
            editorViewModelForElementIDProvider: { _ in MockEditorViewModel() }
        )
    }
}
