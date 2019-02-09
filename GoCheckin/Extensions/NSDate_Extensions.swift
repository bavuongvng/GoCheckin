//
//  NSDate_Extensions.swift
//  GoCheckin
//
//  Created by VuongHN on 2/9/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import Foundation

extension NSDate{
    static func convertToNSDate(string:String) -> NSDate{
        var newString:String = string
        if(string.count > 10){
            newString = String(string[...string.index(string.startIndex,offsetBy:9)])
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: newString)! as NSDate
        return date
    }
    
    static func convertToString(date:NSDate) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let str = dateFormatter.string(from: date as Date)
        return str
    }
}
