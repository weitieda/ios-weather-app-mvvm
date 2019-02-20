//
//  ViewController.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-11.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {

    let currentWeatherViewController = CurrentWeatherViewController()
    
    let weeklyForecastController = WeeklyForecastController()
    
    let topContainer = UIView()
    
    let bottomContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        
        return manager
    }()
    
    private var currentLocation: CLLocation? {
        didSet {
            fetchCity()
            fetchWeather()
        }
    }
    
    private func fetchWeather() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon, completion: {
            response, error in
            if let error = error {
                dump(error)
            } else if let response = response {
                // Nofity CurrentWeatherViewController
                self.currentWeatherViewController.viewModel?.weather = response
                self.weeklyForecastController.viewModel = WeeklyWeatherViewModel(weatherData: response.daily.data)
            }
        })
    }
    
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {
            placemarks, error in
            if let error = error {
                dump(error)
            }
            else if let city = placemarks?.first?.locality {
                // Notify CurrentWeatherViewController
                let l = Location(
                    name: city,
                    latitude: currentLocation.coordinate.latitude,
                    longitude: currentLocation.coordinate.longitude)
                self.currentWeatherViewController.viewModel?.location = l
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupActiveNotification()
        
        currentWeatherViewController.delegate = self
        currentWeatherViewController.viewModel = CurrentWeatherViewModel()
    }
    
    private func setupActiveNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RootViewController.applicationDidBecomeActive(notification:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        // Request user's location.
        requestLocation()
    }
    
    private func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(topContainer)
        let spacing: CGFloat = 12
        topContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        topContainer.heightAnchor.constraint(equalToConstant: (view.frame.height - spacing) / 3).isActive = true
        topContainer.addSubview(currentWeatherViewController.view)
        currentWeatherViewController.view.fillSuperview()

        
        view.addSubview(bottomContainer)
        bottomContainer.anchor(top: topContainer.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: spacing, left: 0, bottom: 0, right: 0))
        bottomContainer.addSubview(weeklyForecastController.view)
        weeklyForecastController.view.fillSuperview()
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.delegate = nil
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        print("Open locations")
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        let vc = SettingsController.init(style: .grouped)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

extension RootViewController: SettingsControllerDelegate {
    func settingsDidChange() {
        currentWeatherViewController.updateView()
        weeklyForecastController.updateView()
    }
}


