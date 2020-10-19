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
    
    public static func buildMockedView() -> some View {
        buildView(
            viewModel: MockImagesViewModel(),
            editorViewModelForElementIDProvider: { _ in MockEditorViewModel() }
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

private struct DesignConstants {
    static let minimumColumnWidth: CGFloat = 50
    static let maximumColumnFractionOfScreenWidth: CGFloat = 0.5
}

struct ImagesView<ViewModel>: View where ViewModel: ImagesViewModelProtocol {
    typealias ElementID = ImageElementState<ViewModel.ImageProvider>.ID

    private struct ViewState {
        var showEditor = false
        var selectedElementID: ElementID?
        var columnWidth: CGFloat = 100
    }

    @ObservedObject var viewModel: ViewModel
    
    @State private var viewState = ViewState()
    
    init(
        viewModel: ViewModel,
        buildEditorView: @escaping (ElementID) -> AnyView?
    ) {
        self.viewModel = viewModel
        self.buildEditorView = buildEditorView
    }
    
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
                        Slider(
                            value: $viewState.columnWidth,
                            in: DesignConstants.minimumColumnWidth ... g.size.width * DesignConstants.maximumColumnFractionOfScreenWidth
                        )
                        
                        GridView(columnWidth: viewState.columnWidth) {
                            ForEach(elements) { element in
                                ImageCellView(
                                    imageProvider: element.imageProvider,
                                    name: element.name
                                )
                                    .aspectRatio(1, contentMode: .fill)
                                    .onTapGesture {
                                        viewState.selectedElementID = element.id
                                        viewState.showEditor.toggle()
                                    }
                                    .sheet(isPresented: $viewState.showEditor) {
                                        viewState.selectedElementID.map(buildEditorView)
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
        ImagesBuilder.buildMockedView()
    }
}
