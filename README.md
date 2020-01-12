# Dark Sky Weather App
### An iOS weather app with MVVM architecture

## Features
1. Get user current geolocation by `CoreLocation` (request for GeoLocation permission)
1. HTTP `GET` request to Dark Sky weather api, and `JSON` parsing by `Decodable`
1. Implemented Delegation, Singleton and Observer Pattern
1. `Auto Layout` UI programtically
1. `UITableView` with customized cell
1. Saved user's setting by `UserDefault`
1. Encapsulated network layer

## Preview
![today](preview/today.GIF)

## Installation
Clone or download the project, navigate to `Config` folder, create a file `Key.swift`, then build. You're good to go.
```
import Foundation

enum Key: String {
    case weatherApiKey = "YOUR_DARK_SKY_API_KEY"
}
```
