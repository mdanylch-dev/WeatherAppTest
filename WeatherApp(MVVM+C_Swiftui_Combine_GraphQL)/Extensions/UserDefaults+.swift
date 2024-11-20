//
//  UserDefaults+.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 15.05.2022.
//

import SwiftUI

extension UserDefaults {
    // MARK: - Cities
    static func setCities(_ cities: [CityModel]) {
        if let encodedData = try? PropertyListEncoder().encode(cities) {
            Self.standard.set(encodedData, forKey: "CITIES_LIST")
        }
    }

    static func getCities() -> [CityModel] {
        guard let data = Self.standard.object(forKey: "CITIES_LIST") as? Data else { return [] }

        if let cities = try? PropertyListDecoder().decode([CityModel].self, from: data) {
            return cities
        } else {
            return []
        }
    }
}
