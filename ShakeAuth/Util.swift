//
//  Util.swift
//  ShakeAuth
//
//  Created by Mike Wang on 11/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import Foundation
import UIKit

func createLinedField(field: UITextField, color: UIColor = UIConstants.primaryColor) {
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = color.CGColor
    border.frame = CGRect(x: 0, y: field.frame.size.height - width, width: field.frame.size.width, height: field.frame.size.height)
    border.borderWidth = width
    field.layer.addSublayer(border)
}

func formatLabel(label: UILabel, text: String, color: UIColor, font: UIFont = UIFont.systemFontOfSize(UIConstants.fontSmall, weight: UIFontWeightRegular), layout: Bool = true) {
    label.text = text
    label.textColor = color
    label.font = font
    if layout {
        label.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(label.intrinsicContentSize().width)
            make.height.equalTo(label.intrinsicContentSize().height)
        }
    }
}

func formatButton(button: UIButton, title: String, color: UIColor = UIColor.whiteColor(), action: Selector?, delegate: UIViewController?) {
    button.setTitle(title, forState: .Normal)
    button.setTitleColor(color, forState: .Normal)
    if action != nil && delegate != nil {
        button.addTarget(delegate, action: action!, forControlEvents: UIControlEvents.TouchUpInside)
    }
}