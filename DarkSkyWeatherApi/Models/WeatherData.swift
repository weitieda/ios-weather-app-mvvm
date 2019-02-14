//
//  WeatherData.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-12.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
}
