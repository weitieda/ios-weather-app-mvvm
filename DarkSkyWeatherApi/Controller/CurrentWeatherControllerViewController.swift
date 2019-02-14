//
//  CurrentWeatherControllerViewController.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-12.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    let locationButton: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "LocationBtn").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    let settingButton: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "Setting").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    let locationLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        return l
    }()
    
    let weatherIcon: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        
        return i
    }()
    
    var now: WeatherData? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }
    
    var location: Location? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let now = now, let location = location {
            updateWeatherContainer(with: now, at: location)
        }
//        else {
//            loadingFailedLabel.isHidden = false
//            loadingFailedLabel.text = "Fetch weather/location failed."
//        }
    }
    
    func updateWeatherContainer(with data: WeatherData, at location: Location) {
        weatherContainerView.isHidden = false
        
        // 1. Set location
        locationLabel.text = location.name
        
        // 2. Format and set temperature
        temperatureLabel.text = String(
            format: "%.1f °C",
            data.currently.temperature.toCelcius())
        
        // 3. Set weather icon
        weatherIcon.image = weatherIcon(
            of: data.currently.icon)
        
        // 4. Format and set humidity
        humidityLabel.text = String(
            format: "%.1f %%",
            data.currently.humidity * 100)
        
        // 5. Set weather summary
        summaryLabel.text = data.currently.summary
        
        // 6. Format and set datetime
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        dateLabel.text = formatter.string(
            from: data.currently.time)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(locationButton)
        locationButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        
        view.addSubview(settingButton)
        settingButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding:.init(top: 8, left: 0, bottom: 0, right: 16))
        
        view.addSubview(locationLabel)
        locationLabel.centerX(in: view)
        locationLabel.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor).isActive = true
    }
    
}
