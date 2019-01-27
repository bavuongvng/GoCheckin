//
//  UIButton_Extensions.swift
//  GoCheckin
//
//  Created by VuongHN on 1/27/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func createNumberButton() {
        layer.cornerRadius = frame.height/2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    
    func setBorderRadius(_ radius: CGFloat, _ borderColor:UIColor?){
        layer.cornerRadius = radius
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = 1
    }
    
    func createNextButton() {
        self.setBorderRadius(30, UIColor.white)
    }
}
