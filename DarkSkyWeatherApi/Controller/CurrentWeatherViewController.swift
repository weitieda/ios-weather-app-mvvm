//
//  CurrentWeatherControllerViewController.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-12.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: CurrentWeatherViewController)
    func settingsButtonPressed(controller: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherViewController {
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    let locationButton: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "LocationBtn").withRenderingMode(.alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(handleLocationPressed), for: .touchUpInside)
        return b
    }()
    
    @objc fileprivate func handleLocationPressed() {
        delegate?.locationButtonPressed(controller: self)
    }
    
    let settingButton: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "Setting").withRenderingMode(.alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(handleSettingPressed), for: .touchUpInside)
        return b
    }()
    
    @objc fileprivate func handleSettingPressed() {
        delegate?.settingsButtonPressed(controller: self)
    }
    
    let locationLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        return l
    }()
    
    let temperatureLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        return l
    }()
    
    let weatherIcon: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    let humidityLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        return l
    }()
    
    let summaryLabel = UILabel()
    
    let dateLabel = UILabel()
    
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
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Fetch weather/location failed."
        }
    }
    
    func updateWeatherContainer(with data: WeatherData, at location: Location) {
        weatherContainerView.isHidden = false
        loadingFailedLabel.isHidden = true
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
        formatter.dateFormat = "E, dd MMMM, yyyy"
        dateLabel.text = formatter.string(
            from: data.currently.time)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .red
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
        
        view.addSubview(weatherIcon)
        weatherIcon.centerInSuperview()
        weatherIcon.widthAnchor.constraint(equalToConstant: 144).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 144).isActive = true
        
        view.addSubview(summaryLabel)
        summaryLabel.anchor(top: weatherIcon.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        summaryLabel.centerX(in: view)
        
        view.addSubview(temperatureLabel)
        temperatureLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: weatherIcon.leadingAnchor)
        temperatureLabel.centerY(in: view)
        
        view.addSubview(humidityLabel)
        humidityLabel.anchor(top: nil, leading: weatherIcon.trailingAnchor, bottom: nil, trailing: view.trailingAnchor)
        humidityLabel.centerY(in: view)
        
        view.addSubview(dateLabel)
        dateLabel.centerX(in: view)
        dateLabel.anchor(top: summaryLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil)
        
        
    }
    
}

extension Double {
    func toCelcius() -> Double {
        return (self - 32.0) / 1.8
    }
}
