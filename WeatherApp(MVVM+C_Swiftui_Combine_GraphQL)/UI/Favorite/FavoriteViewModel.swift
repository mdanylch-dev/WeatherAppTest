//
//  FavoriteViewModel.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 08.05.2022.
//

import Combine

class SecondViewModel: SecondViewModelType {
    private let closeSubject = PassthroughSubject<String, Never>()

    // Inputs
    func close() {
        closeSubject.send(text)
    }

    // Bindings
    @Published var text: String = ""
    @Published var city: [String] = []

    var coordinatorInput: CoordinatorInput!
    var coordinatorOutput: CoordinatorOutput!

    struct CoordinatorInput {
        var close: AnyPublisher<String, Never>
    }

    struct CoordinatorOutput {

    }

    init(city: String) {
        coordinatorInput = CoordinatorInput(close: closeSubject.eraseToAnyPublisher())
        coordinatorOutput = CoordinatorOutput()

        setupSubjects(city)
    }

    private func setupSubjects(_ city: String) {
        if !city.isEmpty {
            self.city.insert(city, at: 0)
        }

    }
}

protocol SecondViewModelType: ObservableObject {
    // Inputs
    func close()

    // Bindings
    var text: String { get set }
    var city: [String] { get }
}
