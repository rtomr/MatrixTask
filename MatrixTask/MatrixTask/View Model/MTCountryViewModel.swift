//
//  MTCountryViewModel.swift
//  MatrixTask
//
//  Created by Tom Regev on 27/11/2020.
//  Copyright © 2020 Tom Regev. All rights reserved.
//

import Foundation

struct MTCountryViewModel {
    let name: String?
    let nativeName: String?
    let area: Float?
    
    init(countryData: MTResponseDataModel) {
        name = countryData.name
        nativeName = countryData.nativeName
        area = countryData.area
    }
}
