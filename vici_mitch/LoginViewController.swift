//
//  ViewController.swift
//  vici_mitch
//
//  Created by Mitch on 6/7/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UITableViewController {
   
    //MARK: Properties
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Add new blank view under table
        self.tableView.tableFooterView = UIView()
    }
    

    
    //MARK: actions
    @IBAction func loginButton(_ sender: UIButton) {
        print("email: \(userNameTextField.text!)")
        print("password: \(passwordTextField.text!)")
        
        
        guard let userName = userNameTextField.text, !userName.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            //TODO: handle error
            return
        }
        let parameters: Parameters = [
            "email":userName,
            "password":password
        ]
        
        Alamofire.request("http://vici.beanstalkweb.com/login.php", method: .post, parameters: parameters).responseJSON { response in
            print(response.result)  // result of response serializaion
            print(response.result.value)
            
            guard let jsonData = response.result.value as? [String: Any] else {
                print("shit. we fucked up")
                return
            }
            
            // MOCKED JSON RESPONSE
            let mockJsonData: [String: Any] = [
                "error": false,
                "message": "Successfully Logged In",
                "uid": "test_uid",
                "user": [
                    "firstName": "test_first_name",
                    "lastName": "test_last_name",
                    "desiredUsername": "test_username",
                    "email": "test_email",
                    "mobilePhone": "test_phone_number",
                    "photoStorage": "test_photo_storage",
                    "userBio": "test_bio"
                ]
            ]
            
            
            
            
        }
    }
    
    
    
    
    
//valid email
 /*   func isValid(_ email: String) -> Bool {
        let emailRegEx = """
            (?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        """
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
 */
}

