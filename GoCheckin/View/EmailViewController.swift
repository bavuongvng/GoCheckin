//
//  EmailViewController.swift
//  GoCheckin
//
//  Created by VuongHN on 1/27/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnNotNow: UIButton!
    @IBOutlet weak var viewACong: UIStackView!
    @IBOutlet weak var viewCham: UIStackView!
    @IBOutlet var btnSuggestions: [UIButton]!
    
    @IBAction func btnACongClick(sender: UIButton) {
        var email = txtEmail.text!
        let index = email.index(of: "@")!.encodedOffset
        email.removeLast(email.count-index)
        txtEmail.text = email+sender.currentTitle!
        
        viewACong.isHidden = true
        viewCham.isHidden = false
    }
    @IBAction func btnChamClick(sender: UIButton) {
        let email = txtEmail.text!
        txtEmail.text = email+sender.currentTitle!
        viewCham.isHidden = true
    }
    @IBAction func onEmailChange(_ sender: Any) {
        let email = txtEmail.text!
        if let index = email.index(of: "@")?.encodedOffset {
            if index == email.count-1{
                viewACong.isHidden = false
                viewCham.isHidden = true
            }else{
                viewACong.isHidden = true
                viewCham.isHidden = false
            }
        }else{
            viewACong.isHidden = true
            viewCham.isHidden = true
        }
    }
    @IBAction func onNext(_ sender: Any) {
    }
    @IBAction func onNotNow(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initial()
    }
    
    func initial(){
        btnNext.createNextButton()
        btnNotNow.createNextButton()
        txtEmail.setBorderBottom()
        
        btnNotNow.createLinear()
        
        
        for btn in btnSuggestions{
            btn.setBorderRadius(btn.frame.height/2, UIColor.white)
        }
        
        let tappedGuesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        view.addGestureRecognizer(tappedGuesture)
        viewCham.isHidden = true
        viewACong.isHidden = true
    }
    
    @objc func tapped(){
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.moveTextField(view: view, moveDistance: 250, up: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.moveTextField(view: view, moveDistance: 250, up: false)
    }

}
