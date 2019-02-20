//
//  SettingsController.swift
//  DarkSkyWeatherApi
//
//  Created by Tieda Wei on 2019-02-18.
//  Copyright © 2019 Tieda Wei. All rights reserved.
//

import UIKit

protocol SettingsControllerDelegate {
    func settingsDidChange()
}

class SettingsController: UITableViewController {
    
    var delegate: SettingsControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
    }
    
    @objc func handleDone() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension SettingsController {
    
    private enum Section: Int, CaseIterable {
        case date
        case temperature
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        
        switch section {
        case .date:
            cell.textLabel?.text = indexPath.row == 0 ? "Fri, 01 December" : "F, 12/01"
            let timeMode = UserDefaults.getDateMode()
            
            if indexPath.row == timeMode.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .temperature:
            cell.textLabel?.text = (indexPath.row == 0) ?
                "Celsius" : "Fahrenheit"
            let temperatureMode = UserDefaults.getTemperatureMode()
            
            if indexPath.row == temperatureMode.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        
        switch section {
        case .date:
            let dateMode = UserDefaults.getDateMode()
            guard indexPath.row != dateMode.rawValue else { return }
            
            if let newMode = DateMode(rawValue: indexPath.row) {
                UserDefaults.setDateMode(to: newMode)
            }
            
            delegate?.settingsDidChange()
        case .temperature:
            let temperatureMode = UserDefaults.getTemperatureMode()
            guard indexPath.row != temperatureMode.rawValue else { return }
            
            if let newMode = TemperatureMode(rawValue: indexPath.row) {
                UserDefaults.setTemperatureMode(to: newMode)
            }
            
            delegate?.settingsDidChange()
        }
        let sections = IndexSet(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Date Format"
        }
        return "Temperature Unit"
    }
}

