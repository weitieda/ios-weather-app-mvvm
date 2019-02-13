//
//  Config.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-12.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import Foundation

struct API {
    static let key = "3b528623e068824d846f8c3a354da9ca"
    static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}
