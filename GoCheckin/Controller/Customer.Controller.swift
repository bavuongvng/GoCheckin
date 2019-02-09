//
//  Customer.Controller.swift
//  GoCheckin
//
//  Created by VuongHN on 2/8/19.
//  Copyright © 2019 VuongHN. All rights reserved.
//

import Foundation

extension Customer{
    static func getAllCustomer(){
        //Setup the url request
        let myUrl =  "http://192.168.1.173:3000/api/customer/"
        guard let url = URL(string: myUrl) else {
            print("Error: Cannot create URL!")
            return
        }
        let urlRequest = URLRequest(url: url)
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
    // handle async
    static func getCustomerByPhone(number:String, dialing_code:String?) -> Customer?{
        let group = DispatchGroup()
        var checkinCustomer:Customer?
        let myUrl =  "http://192.168.1.173:3000/api/customer/\(number)/\(dialing_code ?? "%2B84")"
        guard let url = URL(string: myUrl) else{
            print("Error: Cannot create url!")
            group.leave()
            return nil
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) {
            (data,res,error) in
            
            print("Callback task")
            guard error == nil else{
                print("Error: error calling get request")
                group.leave()
                return
            }
            guard let responseData = data else{
                print("Error: did not receive data")
                group.leave()
                return
            }
            
            do{
                guard let customer = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as?[Dictionary<String,Any>] else{
                        print("Error trying to convert data to json")
                        group.leave()
                        return
                }
                guard customer.count > 0 else{
                    print("New customer")
                    group.leave()
                    return
                }
                
                let id:String = customer[0]["_id"] as! String
                let name:String = customer[0]["name"] as! String
                let email:String = customer[0]["email"] as! String
                let dateOfBirth:NSDate = NSDate.convertToNSDate(string: customer[0]["dateOfBirth"] as! String)
                
                let phoneContact:Dictionary<String,Any> = customer[0]["phone"] as! Dictionary<String, Any>
                let phoneDialing:String = phoneContact["dialing_code"] as! String
                let phonNumber:String = phoneContact["number"] as! String
                let phone:Phone = Phone(number: phonNumber, dialing_code: phoneDialing)

                checkinCustomer = Customer(id: id, name: name, dateOfBirth: dateOfBirth, phone: phone, email: email)
                group.leave()
            }catch{
                print("Error trying to convert data to json")
                group.leave()
                return
            }
        }
       
        task.resume()
        group.enter()
        group.wait()
        return checkinCustomer
    }
    
    static func createNewCustomer(){
        let myUrl =  "http://192.168.1.173:3000/api/customer/create/"
        guard let url = URL(string: myUrl) else{
            print("Error: cannot create url")
            return
        }
        
        var customerUrlRequest = URLRequest(url: url)
        customerUrlRequest.httpMethod = "POST"
        let newCustomer: Dictionary<String,Any> = [
            "name": "Tuyen Nguyen",
            "dateOfBirth": "1997-12-15",
            "email": "tuyennguyen@test.com",
            "phone": [
                "dialing_code": "%2B84",
                "number": "0174235869"
            ]
        ]
        
        let jsonCustomer:Data
        do{
            jsonCustomer = try JSONSerialization.data(withJSONObject: newCustomer, options: [])
            customerUrlRequest.httpBody = jsonCustomer
        }catch{
            print("Error: cannot create json from customer")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: customerUrlRequest) {
            (data,response,error) in
           
            guard error == nil else{
                print("Error: error calling post!")
                print(error!)
                return
            }
            
            guard let responseData = data else{
                print("Did not receive dara!")
                return
            }

            do{
                guard let receiveData = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? Dictionary<String,Any> else{
                        print("Cannot get json from data")
                        return
                }
                print("Data is \(receiveData.description)")

                guard let customerId = receiveData["_id"] else{
                    return print("Cannot get id")
                }

                print("ID customer \(customerId)")
            }catch{
                print("error parsing response from POST on /todos")
                return
            }
        }
        
        task.resume()
    }
}
