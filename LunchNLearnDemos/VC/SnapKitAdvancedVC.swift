//
//  SnapKitAdvancedVC.swift
//  LunchNLearnDemos
//
//  Created by Brendan Lensink on 2018-03-09.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import UIKit

enum ViewState {
    case small
    case medium
    case large
}

class SnapKitAdvancedVC: UIViewController {
    private lazy var slider: UIButton = {
        let view = UIButton()
        view.backgroundColor = .blue
        return view
    }()

    private var viewState: ViewState = .medium {
        didSet {
            if viewState != oldValue {
                switch viewState {
                case .small: layoutSmall()
                case .medium: layoutMedium()
                case .large: layoutLarge()
                }
            }
        }
    }

    private var topContainer: UIView!
    private var bottomContainer: UIView!
    private var topLeftBox: UIView!
    private var topRightBox: UIView!
    private var bottomBox: UIView!

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up our tappable slider

        view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.centerX.equalTo(view)
            make.centerY.equalTo(view.snp.top).offset(view.frame.height / 2)
        }

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(sliderDragged(_:)))
        slider.addGestureRecognizer(panGesture)

        // Set up two containers for the top/bottom portions

        topContainer = UIView()
        topContainer.backgroundColor = UIColor.darkGray
        view.addSubview(topContainer)
            topContainer.snp.makeConstraints { make in
                make.top.left.right.equalTo(view)
                make.bottom.equalTo(slider.snp.top)
            }

        bottomContainer = UIView()
        view.addSubview(bottomContainer)
            bottomContainer.snp.makeConstraints { make in
                make.top.equalTo(slider.snp.bottom)
                make.bottom.left.right.equalTo(view)
            }

        topLeftBox = UIView()
        topLeftBox.backgroundColor = .yellow
        topContainer.addSubview(topLeftBox)
            topLeftBox.snp.makeConstraints { make in
                make.width.equalTo(topContainer).multipliedBy(0.5)
                make.top.left.bottom.equalTo(topContainer)
            }

        topRightBox = UIView()
        topRightBox.backgroundColor = .orange
        topContainer.addSubview(topRightBox)
            topRightBox.snp.makeConstraints { make in
                make.width.equalTo(topContainer).multipliedBy(0.5)
                make.top.right.bottom.equalTo(topContainer)
            }

        bottomBox = UIView()
        bottomBox.backgroundColor = .red
        topContainer.addSubview(bottomBox)
            bottomBox.snp.makeConstraints { make in
                make.top.equalTo(topRightBox.snp.bottom)
                make.bottom.equalTo(topContainer)
                make.left.right.equalTo(view)
            }

        view.bringSubview(toFront: slider)
    }

    // MARK: Actions

    @objc private func sliderDragged(_ sender: UIPanGestureRecognizer) {
        let touchLocation = sender.location(in: view)
        slider.snp.updateConstraints { make in
            make.centerY.equalTo(view.snp.top).offset(touchLocation.y)
        }

        relayoutSubviews()
    }

    // MARK: Helpers

    private func relayoutSubviews() {
        let sliderCenter = slider.center.y
        let frameHeight = view.frame.height
        let smallSize = frameHeight/3
        let mediumSize = frameHeight*5/8

        switch sliderCenter {
        case 0..<smallSize:
            viewState = .small
        case smallSize..<mediumSize:
            viewState = .medium
        case mediumSize..<frameHeight:
            viewState = .large
        default: break
        }
    }

    private func layoutSmall() {
        topLeftBox.snp.remakeConstraints { make in
            make.height.equalTo(topContainer).multipliedBy(0.5)
            make.top.left.right.equalTo(topContainer)
        }

        topRightBox.snp.remakeConstraints { make in
            make.height.equalTo(topContainer).multipliedBy(0.5)
            make.bottom.left.right.equalTo(topContainer)
        }
    }

    private func layoutMedium() {
        topLeftBox.snp.remakeConstraints { make in
            make.height.equalTo(topContainer)
            make.width.equalTo(topContainer).multipliedBy(0.5)
            make.top.left.equalTo(topContainer)
        }

        topRightBox.snp.remakeConstraints { make in
            make.width.equalTo(topContainer).multipliedBy(0.5)
            make.top.right.equalTo(topContainer)
            make.bottom.equalTo(topLeftBox)
        }
    }

    private func layoutLarge() {
        topLeftBox.snp.remakeConstraints { make in
            make.height.equalTo(view).multipliedBy(0.625)
            make.width.equalTo(topContainer).multipliedBy(0.5)
            make.top.left.equalTo(topContainer)
        }

        topRightBox.snp.remakeConstraints { make in
            make.height.equalTo(view).multipliedBy(0.625)
            make.width.equalTo(topContainer).multipliedBy(0.5)
            make.top.right.equalTo(topContainer)
        }
    }
}
