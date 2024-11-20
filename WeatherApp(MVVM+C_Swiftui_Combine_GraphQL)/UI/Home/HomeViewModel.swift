//
//  HomeViewModel.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 08.05.2022.
//

import Foundation
import Combine

class HomeViewModel: HomeViewModelType {

    private let cancelBag = CancelBag()
    private let weatherService = ForecastService()
    private var addToFavorite: String = ""

    // MARK: - Routing
    struct Routing: HomeRoutingProtocol {
        var goToFavorites = PassthroughSubject<String, Never>()
    }

    // MARK: - Bindings
    @Published private(set) var weather: ForecastModel?

    let routing = Routing()

    // MARK: - Intialization

    // MARK: - Actions
    func goToFavorites() {
        routing.goToFavorites.send(self.addToFavorite)
    }

    func addToFavorites() {
        self.addToFavorite = self.weather?.name ?? ""
    }

    struct CoordinatorInput {
        var goToSecondView: AnyPublisher<Void, Never>
    }

    struct CoordinatorOutput {
        var textReceived: PassthroughSubject<String, Never>
    }

    init() {
        fetchWeather(city: "Kyiv")
    }

    func fetchWeather(city: String) {
        weatherService.fetchWeathe(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            }, receiveValue: { [weak self] forecat in
                guard let self = self else { return }

                self.weather = forecat
            })
            .store(in: self.cancelBag)
    }
}

// MARK: - View model protocol
protocol HomeViewModelType: ObservableObject {
    // Inputs
    func goToFavorites()
    func addToFavorites()

    // Outputs
    var weather: ForecastModel? { get }
}

// MARK: - Routing protocol
protocol HomeRoutingProtocol {
    var goToFavorites: PassthroughSubject<String, Never> { get }
}
