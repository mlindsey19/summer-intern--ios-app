//
//  ProfileViewController.swift
//  vici_mitch
//
//  Created by Daniel Reller on 6/22/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        firstNameLabel.text = CurrentUser.firstName!
        lastNameLabel.text = CurrentUser.lastName!
        mobileNumberLabel.text = CurrentUser.mobileNumber!
        emailLabel.text = CurrentUser.email!
        userNameLabel.text = CurrentUser.desiredUsername!
       
        userProfileImage.image = convertBase64ToImage(base64String: CurrentUser.photoStorage)
        
        // background
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        
        // remove empty cells from view
        self.tableView.tableFooterView = UIView()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
