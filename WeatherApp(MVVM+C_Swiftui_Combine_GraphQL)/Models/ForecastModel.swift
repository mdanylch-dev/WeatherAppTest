//
//  ForecastModel.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 11.05.2022.
//

import Foundation

struct ForecastModel: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let country: String
    let weatherTitle: String
    let weatherDescription: String
    let weatherIcon: String
    let temperatureActual: Double
    let temperatureFeels: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let windSpeed: Double
    let windDeg: Int

    init(id: String, name: String, country: String, _ fragment: WeatherFragment) {
        self.id = id
        self.name = name
        self.country = country
        self.weatherTitle = fragment.summary?.title ?? ""
        self.weatherDescription = fragment.summary?.description ?? ""
        self.weatherIcon = fragment.summary?.icon ?? ""
        self.temperatureActual = fragment.temperature?.actual ?? 0
        self.temperatureFeels = fragment.temperature?.feelsLike ?? 0
        self.temperatureMin = fragment.temperature?.min ?? 0
        self.temperatureMax = fragment.temperature?.max ?? 0
        self.windSpeed = fragment.wind?.speed ?? 0
        self.windDeg = fragment.wind?.deg ?? 0
    }
}

struct CityModel: Identifiable, Codable {
    let id: String
    let name: String
    let country: String

    init(id: String, name: String, country: String) {
        self.id = id
        self.name = name
        self.country = country
    }
}
