//
//  HomeCoordinator.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 08.05.2022.
//

import UIKit
import Combine
import SwiftUI

class HomeCoordinator: Coordinator<Void> {

    private let window: UIWindow
    private var router: Router!

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> AnyPublisher<Void, Never> {
        let viewModel = HomeViewModel()
        let viewController = UIHostingController(rootView: HomeView(viewModel: viewModel))
        presentedViewController = viewController

        router = Router(navigationController: UINavigationController(rootViewController: viewController))
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()

        viewModel.routing.goToFavorites
            .flatMap { [weak self, weak router] city -> AnyPublisher<String, Never> in
                guard let self = self, let router = router else { return Empty(completeImmediately: true).eraseToAnyPublisher() }
                return self.coordinate(to: SecondCoordinator(router: router, city: city))
            }
            .sink(receiveValue: { [weak viewModel] text in
                viewModel?.fetchWeather(city: text)
            })
            .store(in: cancelBag)

        return Empty<Void, Never>(completeImmediately: false)
            .eraseToAnyPublisher()
    }
}
