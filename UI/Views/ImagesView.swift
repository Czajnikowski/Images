//
//  ImagesView.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI

public class ImagesBuilder {
    public static func buildView<ViewModel>(
        viewModel: ViewModel
    ) -> some View where ViewModel: ImagesViewModelProtocol {
        ImagesView(viewModel: viewModel)
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
    @ObservedObject var viewModel: ViewModel
    
    @State private var columnWidth: CGFloat = 100
    
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
        ImagesView(viewModel: MockImagesViewModel())
    }
}
