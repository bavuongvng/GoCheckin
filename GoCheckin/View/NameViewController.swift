//
//  NameViewController.swift
//  GoCheckin
//
//  Created by VuongHN on 1/27/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import UIKit

class NameViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnClear: UIButton!
    
    weak var newCustomer:Customer?
    
    @IBAction func onNext(sender: UIButton){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dateOfBirthViewController = storyBoard.instantiateViewController(withIdentifier: "DateOfBirthScene") as! DateOfBirthViewController
        
        newCustomer?.name = txtName.text
        dateOfBirthViewController.newCustomer = newCustomer
        
        self.present(dateOfBirthViewController, animated: true, completion: nil)
    }
    @IBAction func onClear(_ sender: Any) {
        txtName.text = ""
    }
    @IBAction func onNameChange(_ sender: Any) {
        self.toggleBtnClear()
    }
    
    @IBAction func unwindToNameScene(unwins: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        txtName.setBorderBottom()
        btnNext.createNextButton()
        self.toggleBtnClear()
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedView))
        view.addGestureRecognizer(tapGuesture)
    }
    
    @objc func tappedView(){
        view.endEditing(true)
    }
    
    func toggleBtnClear(){
        if txtName.text!.count > 0{
            btnClear.isHidden = false
        }else{
            btnClear.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.moveTextField(view: view, moveDistance: 250, up: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.moveTextField(view: view, moveDistance: 250, up: false)
    }
}
