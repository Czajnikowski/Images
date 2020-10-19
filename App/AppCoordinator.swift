//
//  AppCoordinator.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import SwiftUI
import UI

class AppCoordinator {
    let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = UIHostingController(rootView: buildRootView())
        window.makeKeyAndVisible()
    }
    
    private func buildRootView() -> some View {
        let imagesViewModel = ImagesViewModel(
            service: URLSessionDecodeedValueProvider()
        )
        
        return ImagesBuilder.buildView(
            viewModel: imagesViewModel,
            editorViewModelForElementIDProvider: { elementId -> EditorViewModel? in
                let imageDTO = imagesViewModel.imageDTO(forElementWithID: elementId)
                
                return imageDTO.map(EditorViewModel.init)
            }
        )
    }
}

class EditorViewModel: EditorViewModelProtocol {
    var name: String = "some name from vm"
    
    @Published var imageProvider: LiveSurfaceImageProvider
    
    init(imageDTO: ImageDTO) {
        name = imageDTO.name
        imageProvider = LiveSurfaceImageProvider(imageName: imageDTO.image)
    }
}
