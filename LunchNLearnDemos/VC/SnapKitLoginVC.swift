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
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
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

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
