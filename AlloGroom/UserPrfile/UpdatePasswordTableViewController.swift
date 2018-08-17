//
//  UpdatePasswordTableViewController.swift
//  vici_mitch
//
//  Created by Daniel Reller on 6/25/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit

class UpdatePasswordTableViewController: UITableViewController {
    
    //MARK: Properties
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordCheck: UITextField!
    @IBOutlet weak var togglePassOld: UIButton!
    @IBOutlet weak var togglePassNew: UIButton!
    @IBOutlet weak var togglePassNewCheck: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add new blank view under table
        self.tableView.tableFooterView = UIView()
        
        //backgound
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //MARK: actions
    
    @IBAction func toggleShowOldPass(_ sender: UIButton) {
        if oldPassword.isSecureTextEntry == true {
            oldPassword.isSecureTextEntry = false
            togglePassOld.setImage(#imageLiteral(resourceName: "eyeShow"), for: .normal)
        }
        else if oldPassword.isSecureTextEntry == false {
            oldPassword.isSecureTextEntry = true
            togglePassOld.setImage(#imageLiteral(resourceName: "eyeDoNotShow"), for: .normal)
        }
    }
    @IBAction func toggleShowNewPass(_ sender: UIButton) {
        if newPassword.isSecureTextEntry == true {
            newPassword.isSecureTextEntry = false
            togglePassNew.setImage(#imageLiteral(resourceName: "eyeShow"), for: .normal)
        }
        else if newPassword.isSecureTextEntry == false {
            newPassword.isSecureTextEntry = true
            togglePassNew.setImage(#imageLiteral(resourceName: "eyeDoNotShow"), for: .normal)
        }
    }
    @IBAction func toggleShowNewCheckPass(_ sender: UIButton) {
        if newPasswordCheck.isSecureTextEntry == true {
            newPasswordCheck.isSecureTextEntry = false
            togglePassNewCheck.setImage(#imageLiteral(resourceName: "eyeShow"), for: .normal)
        }
        else if newPasswordCheck.isSecureTextEntry == false {
            newPasswordCheck.isSecureTextEntry = true
            togglePassNewCheck.setImage(#imageLiteral(resourceName: "eyeDoNotShow"), for: .normal)
        }
    }
    
    
    
    @IBAction func updatePasswordButton(_ sender: UIButton) {
        print(CurrentUser.desiredUsername!,CurrentUser.email!, CurrentUser.firstName!, separator: "\n")
        
    }
    
    
    
    
}
