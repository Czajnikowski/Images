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
        ImagesBuilder.buildView(
            viewModel: ImagesViewModel(service: URLSessionDecodeedValueProvider())
        )
    }
}
