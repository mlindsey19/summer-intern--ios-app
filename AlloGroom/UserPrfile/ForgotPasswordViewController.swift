//
//  ForgotPasswordViewController.swift
//  vici_mitch
//
//  Created by Daniel Reller on 6/27/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Add new blank view under table
        self.tableView.tableFooterView = UIView()
        
        //backgound
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
        // Do any additional setup after loading the view.
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
