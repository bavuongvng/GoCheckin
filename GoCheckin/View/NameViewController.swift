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
    
    @IBAction func onNext(sender: UIButton){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dateOfBirthViewController = storyBoard.instantiateViewController(withIdentifier: "DateOfBirthScene")
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
        
        makeGetCall()
    }
    
    func makeGetCall(){
        //Setup the url request
        let myUrl =  "http://192.168.1.173:3000/api/customer/"

        print("Url \(myUrl)")
        guard let url = URL(string: myUrl) else {
            print("Error: Cannot create URL!")
            return
        }
        let urlRequest = URLRequest(url: url)
        print("Url request \(urlRequest)")
        //Setup the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        //make request
        let task = session.dataTask(with: urlRequest){
            (data,res,error) in
            //Check for any errors
            guard error == nil else{
                print("Error calling get request")
                print(error!)
                return
            }

            //make sure we got data
            guard let responseData = data else {
                print("Did not receive data")
                return
            }

            // parse the result as json, since that's what the api provides
            do{
                guard let customers = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [Dictionary<String,Any>] else{
                        print("Error trying to convert data to json")
                        return
                }
              
                //now we have customer
                // let's just print it to prove we can access it
                print("The customer is: " + customers.description)
                print("The customer is: \(customers[1]["_id"] ?? "")")
            }catch{
                print("Error trying to convert json")
                return
            }
        }
        task.resume()
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
