//
//  DateOfBirthViewController.swift
//  GoCheckin
//
//  Created by VuongHN on 1/27/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import UIKit

class DateOfBirthViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtDateOfBirth: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    weak var newCustomer:Customer?
    
    private var datePicker:UIDatePicker?
    
    @IBAction func onClear(_ sender: Any) {
        txtDateOfBirth.text=""
        btnClear.isHidden = true
    }
    @IBAction func onNext(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let emailViewController = storyBoard.instantiateViewController(withIdentifier: "EmailScene") as! EmailViewController
        
        newCustomer?.dateOfBirth = NSDate.convertToNSDate(string: txtDateOfBirth.text!)
        emailViewController.newCustomer = newCustomer
        
        self.present(emailViewController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToDateOfBirthScene(unwind: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initial()
    }
    
    func initial(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(self.onDateChange(datePicker:)), for: .valueChanged)
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        view.addGestureRecognizer(tapGuesture)
        
        txtDateOfBirth.inputView = datePicker
        txtDateOfBirth.setBorderBottom()
        btnNext.createNextButton()
        self.toggleBtnClear()
    }
    
    @objc func tapped(){
        view.endEditing(true)
    }
    
    @objc func onDateChange(datePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txtDateOfBirth.text = dateFormatter.string(from: datePicker.date)
        self.toggleBtnClear()
    }
    
    func toggleBtnClear(){
        if txtDateOfBirth.text!.count > 0{
            btnClear.isHidden = false
        }else{
            btnClear.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.moveTextField(view: view, moveDistance: datePicker!.frame.height, up: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.moveTextField(view: view, moveDistance: datePicker!.frame.height, up: false)
    }
}
