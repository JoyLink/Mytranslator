//
//  CircleButton.swift
//  Mytranslator
//
//  Created by Joy on 3/17/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

var CornRadius: Bool = false

@IBDesignable
class CircleButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 30.0{
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
   
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
