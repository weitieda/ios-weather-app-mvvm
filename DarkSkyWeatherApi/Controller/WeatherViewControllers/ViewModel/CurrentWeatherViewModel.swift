//
//  CurrentWeatherViewModel.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-13.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    
    var isLocationReady = false
    var isWeatherReady = false
    
    var isUpdateReady: Bool {
        return isLocationReady && isWeatherReady
    }
    
    var location: Location! {
        didSet {
            self.isLocationReady = location != nil ? true : false
        }
    }
    
    var weather: WeatherData! {
        didSet {
            self.isWeatherReady = weather != nil ? true : false
        }
    }
    
    var city: String {
        return location.name
    }
    
    var weatherIcon: UIImage {
        return UIImage.weatherIcon(of: weather.currently.icon)!
    }
    
    var temperature: String {
        
        let value = weather.currently.temperature
        
        switch UserDefaults.getTemperatureMode() {
        case .fahrenheit:
            return String(format: "%.1f", value)
        case .celsius:
            return String(format: "%.1f °C", value.toCelsius())
        }
    }
    
    var humidity: String {
        return String(format: "%.1f %%", weather.currently.humidity * 100)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = UserDefaults.getDateMode().format
        
        return formatter.string(from: weather.currently.time)
    }
}
