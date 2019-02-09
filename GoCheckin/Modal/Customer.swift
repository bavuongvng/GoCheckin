//
//  Customer.swift
//  GoCheckin
//
//  Created by VuongHN on 2/8/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import Foundation

struct Phone {
    var dialing_code:String
    var number:String
    
    init(number:String,dialing_code:String) {
        self.number = number
        self.dialing_code = dialing_code
    }
}

class Customer {
    var id:String?
    var name:String?
    var dateOfBirth:NSDate?
    var phone:Phone?
    var email:String?
    
    init() {}
    
    init(id:String,name:String,dateOfBirth:NSDate,phone:Phone,email:String) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.email = email
    }
    
    func toString() {
        print("""
            =====> Customer
            Customer: \(self.name ?? "")
            Phone: \(self.phone?.dialing_code ?? "")\(self.phone?.number ?? "")
            Email: \(self.email ?? "")
            DateOfbirth: \(NSDate.convertToString(date: self.dateOfBirth!) )
        """)
    }
}
