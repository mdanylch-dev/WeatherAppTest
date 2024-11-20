//
//  FavoriteCoordinator.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 08.05.2022.
//


import UIKit
import Combine
import SwiftUI

class SecondCoordinator: Coordinator<String> {
    private let router: Router!
    private let city: String

    init(router: Router, city: String) {
        self.router = router
        self.city = city
    }

    override func start() -> AnyPublisher<String, Never> {
        let viewModel = SecondViewModel(city: city)
        let viewController = UIHostingController(rootView: SecondView(viewModel: viewModel))
        presentedViewController = viewController

        router.push(viewController, isAnimated: true) { [weak viewModel] in
            viewModel?.close()
        }

        return viewModel.coordinatorInput.close
            .handleEvents(receiveOutput: { [weak router, weak viewController] _ in
                guard let viewController = viewController else { return }
                router?.pop(viewController, true)
            })
            .eraseToAnyPublisher()
    }
}

