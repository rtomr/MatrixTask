//
//  MTCountryTableViewCell..swift
//  MatrixTask
//
//  Created by Tom Regev on 27/11/2020.
//  Copyright © 2020 Tom Regev. All rights reserved.
//

import UIKit

class MTCountryTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nativeNameLabel: UILabel!
    
    static let identifier = String(describing: MTCountryTableViewCell.self)
    
    var countryViewModel: MTCountryViewModel? {
        didSet {
            nameLabel.text = countryViewModel?.name
            nativeNameLabel.text = countryViewModel?.nativeName
        }
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }


}
