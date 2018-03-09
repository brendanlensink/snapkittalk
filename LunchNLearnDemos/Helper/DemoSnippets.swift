//
//  DemoSnippets.swift
//  LunchNLearnDemos
//
//  Created by Brendan Lensink on 2018-03-09.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import SnapKit
import UIKit

// Snippets of code for the presentation
class UselessVC: UIViewController {
    private let largeSized = true

    override func viewDidLoad() {
        let demoView = UIView()
        view.addSubview(demoView)

demoView.snp.makeConstraints { make in
    if largeSized {
        make.height.equalTo(100)
    } else {
        make.height.equalTo(50)
    }
    make.width.equalTo(100)
    make.center.equalTo(view)
}
    }
}
