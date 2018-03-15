//
//  IBAdvancedVC.swift
//  LunchNLearnDemos
//
//  Created by Brendan Lensink on 2018-03-15.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import UIKit

class IBAdvancedVC: UIViewController {
    @IBOutlet private var slider: UIView!
    @IBOutlet private var sliderCenterY: NSLayoutConstraint!

    @IBOutlet weak var topContainer: UIView!

    @IBOutlet weak var leftBox: UIView!
    @IBOutlet weak var leftBoxTop: NSLayoutConstraint!
    @IBOutlet weak var leftBoxWidth: NSLayoutConstraint!
    @IBOutlet weak var leftBoxBottom: NSLayoutConstraint!

    @IBOutlet weak var rightBox: UIView!
    @IBOutlet weak var rightBoxTop: NSLayoutConstraint!
    @IBOutlet weak var rightBoxWidth: NSLayoutConstraint!
    @IBOutlet weak var rightBoxBottom: NSLayoutConstraint!

    var leftBoxSmallHeight: NSLayoutConstraint!
    var rightBoxSmallTop: NSLayoutConstraint!
    var rightBoxSmallBottom: NSLayoutConstraint!

    var leftBoxMediumTop: NSLayoutConstraint!
    var leftBoxMediumBottom: NSLayoutConstraint!
    var leftBoxMediumHeight: NSLayoutConstraint!

    var rightBoxMediumTop: NSLayoutConstraint!
    var rightBoxMediumBottom: NSLayoutConstraint!

    var leftBoxLargeHeight: NSLayoutConstraint!
    var rightBoxLargeHeight: NSLayoutConstraint!

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(sliderDragged(_:)))
        slider.addGestureRecognizer(panGesture)

        // Small Constraints

        leftBoxSmallHeight = NSLayoutConstraint(item: leftBox, attribute: .height, relatedBy: .equal, toItem: topContainer, attribute: .height, multiplier: 0.5, constant: 0)
        rightBoxSmallTop = NSLayoutConstraint(item: rightBox, attribute: .bottom, relatedBy: .equal, toItem: topContainer, attribute: .bottom, multiplier: 1, constant: 0)
        rightBoxSmallBottom = NSLayoutConstraint(item: rightBox, attribute: .top, relatedBy: .equal, toItem: leftBox, attribute: .top, multiplier: 1, constant: 0)

        // Medium Constraints

        leftBoxMediumTop = NSLayoutConstraint(item: leftBox, attribute: .top, relatedBy: .equal, toItem: topContainer, attribute: .top, multiplier: 1, constant: 0)
        leftBoxMediumBottom = NSLayoutConstraint(item: leftBox, attribute: .bottom, relatedBy: .equal, toItem: topContainer, attribute: .bottom, multiplier: 1, constant: 0)
        leftBoxMediumHeight = NSLayoutConstraint(item: leftBox, attribute: .height, relatedBy: .equal, toItem: topContainer, attribute: .height, multiplier: 1, constant: 0)

        rightBoxMediumTop = NSLayoutConstraint(item: rightBox, attribute: .top, relatedBy: .equal, toItem: topContainer, attribute: .top, multiplier: 1, constant: 0)
        rightBoxMediumBottom = NSLayoutConstraint(item: rightBox, attribute: .bottom, relatedBy: .equal, toItem: topContainer, attribute: .bottom, multiplier: 1, constant: 0)

        // Large Constraints

        leftBoxLargeHeight = NSLayoutConstraint(item: leftBox, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.625, constant: 0)
        rightBoxLargeHeight = NSLayoutConstraint(item: rightBox, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.625, constant: 0)
    }

    // MARK: Actions

    @objc private func sliderDragged(_ sender: UIPanGestureRecognizer) {
        let touchLocation = sender.location(in: view)
        sliderCenterY.constant = touchLocation.y - view.frame.height/2

        relayoutSubviews()
    }

    // MARK: Helpers

    private func relayoutSubviews() {
        let sliderCenter = view.frame.height/2 + sliderCenterY.constant
        let frameHeight = view.frame.height
        let smallSize = frameHeight/3
        let mediumSize = frameHeight*5/8

        switch sliderCenter {
        case 0..<smallSize:
            // Remove all medium constraints
            leftBox.removeConstraints(leftBox.constraints)
            rightBox.removeConstraints(rightBox.constraints)
            topContainer.removeConstraints([
                leftBoxMediumTop,
                leftBoxMediumBottom,
                leftBoxMediumHeight,
                rightBoxMediumTop,
                rightBoxMediumBottom
            ])

            // Position left box
            leftBoxWidth = leftBoxWidth.setMultiplier(multiplier: 1)
            topContainer.addConstraint(leftBoxSmallHeight)

            // Position right box
            rightBoxWidth = rightBoxWidth.setMultiplier(multiplier: 1)
            topContainer.addConstraint(rightBoxSmallTop)
            topContainer.addConstraint(rightBoxSmallBottom)
        case smallSize..<mediumSize:
            // Remove all small and large constraints
            leftBox.removeConstraints(leftBox.constraints)
            rightBox.removeConstraints(rightBox.constraints)
            topContainer.removeConstraints([
                leftBoxSmallHeight,
                rightBoxSmallTop,
                rightBoxSmallBottom
            ])
            view.removeConstraints([
                leftBoxLargeHeight,
                rightBoxLargeHeight
            ])

            // Position left box
            leftBoxWidth = leftBoxWidth.setMultiplier(multiplier: 0.5)
            topContainer.addConstraint(leftBoxMediumBottom)
            topContainer.addConstraint(leftBoxMediumTop)
            topContainer.addConstraint(leftBoxMediumHeight)

            // Position right box
            rightBoxWidth = rightBoxWidth.setMultiplier(multiplier: 0.5)
            topContainer.addConstraint(rightBoxMediumTop)
            topContainer.addConstraint(rightBoxMediumBottom)
        case mediumSize..<frameHeight:
            // Remove all medium constraints
            leftBox.removeConstraints(leftBox.constraints)
            rightBox.removeConstraints(rightBox.constraints)
            topContainer.removeConstraints([
                leftBoxMediumBottom,
                leftBoxMediumHeight,
                rightBoxMediumBottom
            ])

            view.addConstraint(leftBoxLargeHeight)
            view.addConstraint(rightBoxLargeHeight)

        default: break
        }
    }
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint

     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
