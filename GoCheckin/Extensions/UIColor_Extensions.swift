//
//  UIColor_Extensions.swift
//  GoCheckin
//
//  Created by VuongHN on 1/27/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func rgba(_ red: CGFloat,_ green: CGFloat,_ blue:CGFloat,_ alpha: CGFloat = 1) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
