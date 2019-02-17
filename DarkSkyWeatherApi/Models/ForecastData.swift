//
//  ForecastData.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-17.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    let time: Date
    let temperatureLow: Double
    let temperatureHigh: Double
    let icon: String
    let humidity: Double
}
