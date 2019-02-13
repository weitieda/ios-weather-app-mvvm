//
//  WeatherViewController.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-12.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    let weatherContainerView = UIView()
    
    let loadingFailedLabel: UILabel = {
        let l = UILabel()
        l.backgroundColor = .red
        l.text = "Error"
        l.textAlignment = .center
        return l
    }()
    
    let activityIndicatorView = UIActivityIndicatorView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.addSubview(weatherContainerView)
        weatherContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(loadingFailedLabel)
        loadingFailedLabel.centerX(in: view)
        loadingFailedLabel.centerY(in: view)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerX(in: view)
        activityIndicatorView.centerY(in: view)
        
        weatherContainerView.isHidden = true
        loadingFailedLabel.isHidden = true
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.style = .gray
        activityIndicatorView.hidesWhenStopped = true
    }
    
    func weatherIcon(of name: String) -> UIImage? {
        switch name {
        case "clear-day":
            return UIImage(named: "clear-day")
        case "clear-night":
            return UIImage(named: "clear-night")
        case "rain":
            return UIImage(named: "rain")
        case "snow":
            return UIImage(named: "snow")
        case "sleet":
            return UIImage(named: "sleet")
        case "wind":
            return UIImage(named: "wind")
        case "cloudy":
            return UIImage(named: "cloudy")
        case "partly-cloudy-day":
            return UIImage(named: "partly-cloudy-day")
        case "partly-cloudy-night":
            return UIImage(named: "partly-cloudy-night")
        default:
            return UIImage(named: "clear-day")
        }
    }
}
