//
//  SnapKitBasicVC.swift
//  LunchNLearnDemos
//
//  Created by Brendan Lensink on 2018-03-09.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import SnapKit
import UIKit

class SnapKitBasicVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let boxyMcBoxFace = UIView()
        boxyMcBoxFace.backgroundColor = .blue
        view.addSubview(boxyMcBoxFace)

        boxyMcBoxFace.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
    }
}
