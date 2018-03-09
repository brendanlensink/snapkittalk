//
//  UITextField+BottomBorder.swift
//  LunchNLearnDemos
//
//  Created by Brendan Lensink on 2018-03-09.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import UIKit

// c/o https://stackoverflow.com/a/41291113/6718381
extension UITextField {
    func setBottomBorder() {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor

        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
}
