//
//  WeeklyForcastCell.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-17.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

class WeeklyForecastCell: UITableViewCell {

    let weekLabel: UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 0.9149611592, green: 0.2951304317, blue: 0.2124379277, alpha: 1)
        l.font = UIFont.preferredFont(forTextStyle: .title3)
        return l
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let temperatureLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let humidLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        return l
    }()
    
    let weatherIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var leftStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [weekLabel, dateLabel, temperatureLabel])
        s.axis = .vertical
        return s
    }()
    
    lazy var rightStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [weatherIcon, humidLabel])
        s.axis = .vertical
        return s
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        contentView.backgroundColor = .white
        setupViews()
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(leftStackView)
        leftStackView.centerY(in: contentView)
        leftStackView.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        contentView.addSubview(rightStackView)
        weatherIcon.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 40, height: 40))
        rightStackView.centerY(in: contentView)
        rightStackView.anchor(top: nil, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
