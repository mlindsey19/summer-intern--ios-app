//
//  TableViewController.swift
//  vici_mitch
//
//  Created by Daniel Reller on 6/14/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit


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

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //MARK: actions
    @IBAction func registerButton(_ sender: UIButton) {
        print("firstName: \(firstNameRegister.text!)")
        print("lastName: \(lastNameRegister.text!)")
        print("userNAme: \(userNameRegister.text!)")
        print("number: \(mobileNumberRegister.text!)")
        print("email: \(emailRegister.text!)")
        print("password: \(passwordRegister.text!)") //delete
        
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

    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
