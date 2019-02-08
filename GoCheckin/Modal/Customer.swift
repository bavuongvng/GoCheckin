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
}

class Customer {
    private var id:String?
    private var name:String?
    private var dateOfBirth:NSDate?
    private var phone:Phone?
    private var email:String?
    
    init(id:String,name:String,dateOfBirth:NSDate,phone:Phone,email:String) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.email = email
    }
}
