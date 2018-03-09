//
//  SnapKitLoginVC.swift
//  LunchNLearnDemos
//
//  Created by Brendan Lensink on 2018-03-09.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import UIKit

class SnapKitLoginVC: UIViewController {
    private lazy var usernameField: UITextField = {
        let field = UITextField()
        field.setBottomBorder()
        return field
    }()

    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.setBottomBorder()
        return field
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        button.layer.cornerRadius = 7
        button.setTitle("LOGIN", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let padding = 25

        view.addSubview(usernameField)
        usernameField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view).offset(4 * padding)
            make.leading.trailing.equalTo(view).inset(padding)
        }

        view.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.height.equalTo(usernameField)
            make.top.equalTo(usernameField.snp.bottom).offset(padding)
            make.leading.trailing.equalTo(view).inset(padding)
        }

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(usernameField)
            make.top.equalTo(passwordField.snp.bottom).offset(padding)
            make.leading.trailing.equalTo(view).inset(padding)
        }
    }
}
