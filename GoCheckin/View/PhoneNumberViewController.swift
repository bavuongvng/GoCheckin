//
//  PhoneNumberViewController.swift
//  GoCheckin
//
//  Created by VuongHN on 1/27/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    
    @IBOutlet var btnNum: [UIButton]!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var btnSuccess: UIButton!
    
    var newCustomer:Customer = Customer()
    
    @IBAction func onClear(_ sender: Any) {
        lblPhone.text = ""
        toggleButtonClearAndRemove()
    }
    @IBAction func onRemove(_ sender: Any) {
        var phone = lblPhone.text!
        if phone.count > 0{
            phone.removeLast()
            lblPhone.text = phone
        }
        toggleButtonClearAndRemove()
    }
    @IBAction func onNumberPress(sender: UIButton) {
        let phone = lblPhone.text ?? ""
        lblPhone.text = phone + sender.currentTitle!
        toggleButtonClearAndRemove()
    }
    @IBAction func onSuccess(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let customerCheckin = Customer.getCustomerByPhone(number: lblPhone.text ?? "", dialing_code: nil)
        
        if customerCheckin?.id != nil{
            let selectStaffViewController = storyBoard.instantiateViewController(withIdentifier: "SelectStaffScene") as! SelectStaffViewController
            selectStaffViewController.newCustomer = customerCheckin
            self.present(selectStaffViewController, animated: true, completion: nil)
            return
        }
        
        let phone = Phone(number: lblPhone.text!, dialing_code: "+84")
        newCustomer.phone = phone
        
        let nameViewController = storyBoard.instantiateViewController(withIdentifier: "NameScene") as! NameViewController
        nameViewController.newCustomer = newCustomer
        
        self.present(nameViewController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToPhoneScreen(unwind: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        for btn in btnNum{
            btn.createNumberButton()
        }
        toggleButtonClearAndRemove()
    }
    func toggleButtonClearAndRemove() {
        let length = lblPhone.text!.count
        if length > 0{
            btnRemove.isHidden = false
            btnClear.isHidden = false
        }else{
            btnRemove.isHidden = true
            btnClear.isHidden = true
        }
    }
}
