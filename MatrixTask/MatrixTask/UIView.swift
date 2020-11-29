//
//  UIView.swift
//  MatrixTask
//
//  Created by Tom Regev on 28/11/2020.
//  Copyright © 2020 Tom Regev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubview(_ subview: UIView, constrainedTo anchorsView: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
            subview.widthAnchor.constraint(equalTo: anchorsView.widthAnchor),
            subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor)
        ])
    }
    
}
