//
//  MTMainScreenVC.swift
//  MatrixTask
//
//  Created by Tom Regev on 27/11/2020.
//  Copyright © 2020 Tom Regev. All rights reserved.
//

import UIKit
import Alamofire

class MTMainScreenVC: UIViewController {
    
    @IBOutlet private weak var countriesTableView: UITableView!
    @IBOutlet private weak var sortView: MTSortView!
    
    private var countriesData: [MTResponseDataModel] = []
    private var sortedCountriesData: [MTResponseDataModel] = []
    private var countriesViewModel: [MTCountryViewModel] = []
    private var borderingCountriesData: [MTCountryViewModel] = []
    private var countriesCodeDict: [String:Int] = [:]
    
    private let url = "https://restcountries.eu/rest/v2/all"

    override func viewDidLoad() {
        super.viewDidLoad()
        sortView.delegate = self
        
        fetchData() { (data) in
            if let data = data {
                self.countriesData = data
                self.sortedCountriesData = data
                self.countriesViewModel = data.map({return MTCountryViewModel(countryData: $0)})
                self.configureTableView()
                self.initCountriesCodeDict()
            }
        }
    }
    
    func fetchData(completion: @escaping ([MTResponseDataModel]?) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: [MTResponseDataModel].self) { (response) in
                guard let data = response.value else { return }
                completion(data)
        }
    }

    func configureTableView() {
        countriesTableView.register(MTCountryTableViewCell.getNib(), forCellReuseIdentifier: MTCountryTableViewCell.identifier)
        countriesTableView.rowHeight = UITableView.automaticDimension
        countriesTableView.estimatedRowHeight = 100
        countriesTableView.bounces = false
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
    }

    func initCountriesCodeDict() {
        //maps country code to country index in original data
        for (index,country) in countriesData.enumerated() {
            guard let countryCode = country.alpha3Code else {continue}
            countriesCodeDict[countryCode] = index
        }
    }
    
    func getBoarderingCountries(sortedIndex: Int) {
        if let borderingCountries = sortedCountriesData[sortedIndex].borders {
            for borderCountryCode in borderingCountries {
                if let borderingCountryIndex = countriesCodeDict[borderCountryCode] {
                    borderingCountriesData.append(MTCountryViewModel(countryData: countriesData[borderingCountryIndex]))
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let borderingCountriesVC = segue.destination as? MTBorderingCountriesVC {
            borderingCountriesVC.borderingCountriesData = borderingCountriesData
            borderingCountriesVC.presentationController?.delegate = self;
        }
    }
}


extension MTMainScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: MTCountryTableViewCell.identifier, for: indexPath) as! MTCountryTableViewCell
        cell.countryViewModel = countriesViewModel[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getBoarderingCountries(sortedIndex: indexPath.row)
        performSegue(withIdentifier: "nextSegue", sender: nil)
    }
}


extension MTMainScreenVC: MTSortViewDelegate {
    func didPressSortButton(by property: SortType) {
        switch property {
        case .nameAscending:
            sortedCountriesData.sort(by:{($0.name ?? "") < ($1.name ?? "")})
        case .nameDescending:
            sortedCountriesData.sort(by:{($0.name ?? "") > ($1.name ?? "")})
        case .areaAscending:
            sortedCountriesData.sort(by:{($0.area ?? 0) < ($1.area ?? 0)})
        case .areaDescending:
            sortedCountriesData.sort(by:{($0.area ?? 0) > ($1.area ?? 0)})
        }
        
        self.countriesViewModel = sortedCountriesData.map({return MTCountryViewModel(countryData: $0)})
        countriesTableView.reloadData()
    }
}


extension MTMainScreenVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        //clear boardering countries array, when presented VC is dismissed
        borderingCountriesData = []
    }
}
