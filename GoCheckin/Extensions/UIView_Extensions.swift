//
//  UIView_Extensions.swift
//  GoCheckin
//
//  Created by VuongHN on 1/28/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func createLinear(){
        let layerss = CAGradientLayer()
        layerss.frame = bounds
        layerss.colors = [UIColor.yellow.cgColor,UIColor.green.cgColor]
        layerss.locations = [0.0,1.0]
        layerss.startPoint = CGPoint(x: 1.0, y: 1.0)
        layerss.endPoint =  CGPoint(x: 0.0, y: 0.0)
        
        layer.masksToBounds = true
        layer.insertSublayer(layerss, at: 0)
    }
}
