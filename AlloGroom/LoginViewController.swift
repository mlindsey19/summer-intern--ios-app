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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var toggleShowPassword: UIButton!
    @IBOutlet weak var loginNotSuccessfulLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add new blank view under table
        self.tableView.tableFooterView = UIView()
        
        //backgound
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        //hide unsucessful label
        loginNotSuccessfulLabel.isHidden = true
        
    }
    
    
    //MARK: actions
    @IBAction func loginButton(_ sender: UIButton) {
        print("email: \(emailTextField.text!)")
        print("password: \(passwordTextField.text!)")
        
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            //TODO: handle error
            return
        }
        let parameters: Parameters = [
            Keys.email: email,
            Keys.password: password
        ]
        
        Alamofire.request(URL.login, method: .post, parameters: parameters).responseJSON { response in
            print(response.result)  // result of response serializaion
            
            guard let data = response.data else {print("data var not initilized correctly"); return}
            let decoder = JSONDecoder()
            guard let userInfo = try? decoder.decode(JSONResponseStruct.self, from: data)
                else {print("did not parse correctly")
                    return
            }
            //response when loing unsuccesful
            if userInfo.error == true {
                // notify user TODO: check for correct email
                self.loginNotSuccessfulLabel.isHidden = false
                return
            }
            
            // assign user info to static var
            CurrentUser.firstName = userInfo.firstName!
            CurrentUser.lastName = userInfo.lastName!
            CurrentUser.desiredUsername = userInfo.desiredUsername!
            CurrentUser.mobileNumber = userInfo.mobileNumber!
            CurrentUser.email = userInfo.email!
            CurrentUser.photoStorage = userInfo.photoStorage!
            CurrentUser.error = userInfo.error!
            CurrentUser.message = userInfo.message!
            CurrentUser.uniqueID = userInfo.uniqueID!
            
            
            // redirected to homescreene if register succesfully
            
            let loginSuccess = "Login Successful"
            if userInfo.message == loginSuccess {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "homeView")
                self.present(viewController, animated: true, completion: nil)
            }
            else {
                //TODO: handle register error
            }
            
        }
    }
    
    
    //toggle secure password entry
    //TODO: add code to keep password after secure text is re-enabled but check if security issue
    
    @IBAction func toggleShowPassword(_ sender: UIButton) {
        
        if passwordTextField.isSecureTextEntry == true {
            passwordTextField.isSecureTextEntry = false
            toggleShowPassword.setImage(#imageLiteral(resourceName: "eyeShow"), for: .normal)
        }
        else if passwordTextField.isSecureTextEntry == false {
            passwordTextField.isSecureTextEntry = true
            toggleShowPassword.setImage(#imageLiteral(resourceName: "eyeDoNotShow"), for: .normal)
        }
    }
    
    
    
  
}

