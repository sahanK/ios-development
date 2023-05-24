//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Sahan Walpita on 2023-03-08.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
