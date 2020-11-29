//
//  MTResponseDataModel.swift
//  MatrixTask
//
//  Created by Tom Regev on 27/11/2020.
//  Copyright © 2020 Tom Regev. All rights reserved.
//

import Foundation

struct MTResponseDataModel: Codable {
    var name: String?
    var alpha3Code: String?
    var nativeName: String?
    var area: Float?
    var borders: [String]?
}
