//
//  SelectStaffViewController.swift
//  GoCheckin
//
//  Created by VuongHN on 2/9/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import UIKit

class SelectStaffViewController: UIViewController {
    
    weak var newCustomer:Customer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("=====> You are")
        newCustomer?.toString()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
