//
//  MTSortView.swift
//  MatrixTask
//
//  Created by Tom Regev on 28/11/2020.
//  Copyright © 2020 Tom Regev. All rights reserved.
//

import UIKit

enum SortType {
    case nameAscending, nameDescending, areaAscending, areaDescending
}

protocol MTSortViewDelegate: class {
    func didPressSortButton(by property: SortType)
}

class MTSortView: UIView {
    
    @IBOutlet private weak var sortByNameAscendingButton: UIButton!
    @IBOutlet private weak var sortByNameDescendingButton: UIButton!
    @IBOutlet private weak var sortByAreaAscendingButton: UIButton!
    @IBOutlet private weak var sortByAreaDecendingButton: UIButton!
    
    private var sortType: SortType!
    
    weak var delegate: MTSortViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let sortView = Bundle(for: MTSortView.self).loadNibNamed("\(MTSortView.self)", owner: self)?.first as! UIView
        
        addSubview(sortView, constrainedTo: self)
    }
    
    
    @IBAction func didPressSortByNameAscendingButton(_ sender: Any) {
        delegate?.didPressSortButton(by: .nameAscending)
    }
    
    @IBAction func didPressSortByNameDescendingButton(_ sender: Any) {
        delegate?.didPressSortButton(by: .nameDescending)
    }
    
    @IBAction func didPressSortByAreaAscendingButton(_ sender: Any) {
        delegate?.didPressSortButton(by: .areaAscending)
    }
    
    @IBAction func didPressSortByAreaDescendingButton(_ sender: Any) {
        delegate?.didPressSortButton(by: .areaDescending)
    }
}
