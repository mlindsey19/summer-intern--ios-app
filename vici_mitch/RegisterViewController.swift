//
//  TableViewController.swift
//  vici_mitch
//
//  Created by Daniel Reller on 6/14/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var firstNameRegister: UITextField!
    @IBOutlet weak var lastNameRegister: UITextField!
    @IBOutlet weak var userNameRegister: UITextField!
    @IBOutlet weak var mobileNumberRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var passwordCheck: UITextField!
    @IBOutlet weak var togglePassword1: UIButton!
    @IBOutlet weak var togglePassword2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        
        
        //clear bottom of table view
        self.tableView.tableFooterView = UIView()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
    
    //MARK: actions
    @IBAction func registerButton(_ sender: UIButton) {
        //        print("firstName: \(firstNameRegister.text!)")
        //        print("lastName: \(lastNameRegister.text!)")
        //        print("userNAme: \(userNameRegister.text!)")
        //        print("number: \(mobileNumberRegister.text!)")
        //        print("email: \(emailRegister.text!)")
        //        print("password: \(passwordRegister.text!)") //delete
        
        guard   let firstName = firstNameRegister.text, !firstName.isEmpty,
            let lastName = lastNameRegister.text, !lastName.isEmpty,
            let userName = userNameRegister.text, !userName.isEmpty,
            let email = emailRegister.text, !email.isEmpty,
            let password = passwordRegister.text, !password.isEmpty,
            let mobileNumber = mobileNumberRegister.text, !mobileNumber.isEmpty
            else {
                //TODO: handle error
                return
        }
        
        let parameters: Parameters = [
            Keys.firstName:firstName,
            Keys.lastName:lastName,
            Keys.desiredUserName:userName,
            Keys.email:email,
            Keys.mobileNumber:mobileNumber,
            Keys.password:password
        ]
        
        Alamofire.request(URL.register, method: .post, parameters: parameters).responseJSON { response in
            print(response.result)  // result of response serializaion
            
            guard let data = response.data else {print("data var not initilized correctly"); return}
            let decoder = JSONDecoder()
            guard let userInfo = try? decoder.decode(JSONResponseStruct.self, from: data)
                else {print("did not parse correctly")
                    return
            }
            
            // assign user info to static var
            CurrentUser.firstName = userInfo.firstName!
            CurrentUser.lastName = userInfo.lastName!
            CurrentUser.desiredUsername = userInfo.desiredUsername!
            CurrentUser.mobileNumber = userInfo.mobileNumber!
            CurrentUser.email = userInfo.email!
            CurrentUser.photoStorage = userInfo.photoStorage!
            CurrentUser.userBio = userInfo.userBio!
            CurrentUser.error = userInfo.error!
            CurrentUser.message = userInfo.message!
            
            
            // redirected to homescreene if register succesfully
            
            let loginSuccess = "Registered Successfully"
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
    
    
    func handleJSONResponse(response: DataResponse<Any>){
        
    }
    
    //toggle show password
    @IBAction func toggleShowPassword1(_ sender: UIButton) {
        if passwordRegister.isSecureTextEntry == true {
            passwordRegister.isSecureTextEntry = false
            togglePassword1.setImage(#imageLiteral(resourceName: "eyeShow"), for: .normal)
        }
        else if passwordRegister.isSecureTextEntry == false {
            passwordRegister.isSecureTextEntry = true
            togglePassword1.setImage(#imageLiteral(resourceName: "eyeDoNotShow"), for: .normal)
        }
    }
    @IBAction func toggleShowPassword2(_ sender: UIButton) {
        if passwordCheck.isSecureTextEntry == true {
            passwordCheck.isSecureTextEntry = false
            togglePassword2.setImage(#imageLiteral(resourceName: "eyeShow"), for: .normal)
        }
        else if passwordCheck.isSecureTextEntry == false {
            passwordCheck.isSecureTextEntry = true
            togglePassword2.setImage(#imageLiteral(resourceName: "eyeDoNotShow"), for: .normal)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
