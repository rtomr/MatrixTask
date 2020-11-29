//
//  MTBorderingCountriesVC.swift
//  MatrixTask
//
//  Created by Tom Regev on 27/11/2020.
//  Copyright © 2020 Tom Regev. All rights reserved.
//

import Foundation
import UIKit

class MTBorderingCountriesVC: UIViewController {
    
    @IBOutlet private weak var borderingCountriesTableView: UITableView!
    
    var borderingCountriesData: [MTCountryViewModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if borderingCountriesData.count != 0 {
            configureTableView()
        }
        else {
            borderingCountriesTableView.removeFromSuperview()
            showNoBorderingCountriesLabel()
        }
    }
    
    func showNoBorderingCountriesLabel() {
        let noBoarderingCountriesLabel = UILabel()
        noBoarderingCountriesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(noBoarderingCountriesLabel)
        
        let horizontalConstraint = noBoarderingCountriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = noBoarderingCountriesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
        noBoarderingCountriesLabel.text = "No bordering countries"
    }
    
    func configureTableView() {
        borderingCountriesTableView.register(MTCountryTableViewCell.getNib(), forCellReuseIdentifier: MTCountryTableViewCell.identifier)

        borderingCountriesTableView.rowHeight = UITableView.automaticDimension
        borderingCountriesTableView.estimatedRowHeight = 100        
        borderingCountriesTableView.bounces = false

        borderingCountriesTableView.dataSource = self
    }
        
}

extension MTBorderingCountriesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        borderingCountriesData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = borderingCountriesTableView.dequeueReusableCell(withIdentifier: MTCountryTableViewCell.identifier, for: indexPath) as! MTCountryTableViewCell
        cell.countryViewModel = borderingCountriesData[indexPath.row]
        return cell
    }
}
