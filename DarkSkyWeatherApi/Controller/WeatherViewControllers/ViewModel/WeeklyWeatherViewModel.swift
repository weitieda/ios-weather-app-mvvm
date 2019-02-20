//
//  WeeklyWeatherViewModel.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-17.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

struct WeeklyWeatherViewModel {
    
    let weatherData: [ForecastData]
    
    private let dateFormatter = DateFormatter()
    
    func week(for index: Int) -> String {
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: weatherData[index].time)
    }
    
    func date(for index: Int) -> String {
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: weatherData[index].time)
    }
    
    func temperature(for index: Int) -> String {
        let min = format(temperature: weatherData[index].temperatureLow)
        let max = format(temperature: weatherData[index].temperatureHigh)
        
        return "\(min)    \(max)"
    }
    
    private func format(temperature: Double) -> String {
        switch UserDefaults.getTemperatureMode() {
        case .celsius:
            return String(format: "%.0f °C", temperature.toCelsius())
        case .fahrenheit:
            return String(format: "%.0f °F", temperature)
        }
    }
    
    func weatherIcon(for index: Int) -> UIImage? {
        return UIImage.weatherIcon(of: weatherData[index].icon)
    }
    
    func humidity(for index: Int) -> String {
        return String(format: "%.0f %%", weatherData[index].humidity * 100)
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
}









