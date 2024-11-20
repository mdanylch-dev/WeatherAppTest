//
//  ForecastService.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 11.05.2022.
//

import Foundation
import Combine

struct ForecastService {
    private let cancelBag = CancelBag()

    func fetchWeathe(for city: String) -> AnyPublisher<ForecastModel, Error> {
        let subject = CurrentValueSubject<ForecastModel?, Error>(nil)

        print("-------------------------------")
        print("Start ForecastQuery for: \(city)")

        let query = ForecastResulQueryQuery(name: city, config: .init(units: .metric, lang: .en))
        NetworkApolloController.shared.client.fetch(query: query) { result in
            switch result {
            case let .success(graphQLResult):
                guard let forecastResults = graphQLResult.data else {
                    if let error = graphQLResult.errors?.first {
                        print("ForecastQuery FAILED with error: \(error)")
                        print("-------------------------------")

                        subject.send(completion: (.failure(error)))
                    }
                    break
                }

                if let weather = forecastResults.getCityByName?.weather?.fragments.weatherFragment,
                   let id = forecastResults.getCityByName?.id,
                   let name = forecastResults.getCityByName?.name,
                   let country = forecastResults.getCityByName?.country {

                    let forecastResult = ForecastModel(id: id, name: name, country: country, weather)

                    print("ForecastQuery FINISHED")
                    print(forecastResult)
                    print("-------------------------------")
                    subject.send(forecastResult)
                    subject.send(completion: .finished)
                }

            case let .failure(error):
                print("ForecastQuery FAILED with error: \(error)")
                print("-------------------------------")
                subject.send(completion: (.failure(error)))
            }
        }
        return subject.compactMap({ $0 }).eraseToAnyPublisher()
    }
}

