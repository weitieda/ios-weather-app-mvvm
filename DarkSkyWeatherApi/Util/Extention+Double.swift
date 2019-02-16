//
//  Extention+Double.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-15.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import Foundation

extension Double {
    func toCelcius() -> Double {
        return (self - 32.0) / 1.8
    }
}
