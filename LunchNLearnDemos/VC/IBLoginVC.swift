//
//  IBLoginVC.swift
//  LunchNLearnDemos
//
//  Created by Brendan Lensink on 2018-03-09.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import UIKit

class IBLoginVC: UIViewController {
    @IBOutlet private var usernameField: UITextField! {
        didSet {
            usernameField.setBottomBorder()
        }
    }

    @IBOutlet private var passwordField: UITextField! {
        didSet {
            passwordField.setBottomBorder()
        }
    }

    @IBOutlet private var loginButton: UIButton! {
        didSet {
            loginButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
            loginButton.layer.cornerRadius = 7
        }
    }
}
