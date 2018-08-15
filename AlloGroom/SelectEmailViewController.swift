//
//  ViewController.swift
//  AlloGroom
//
//  Created by Daniel Reller on 8/14/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit

class SelectEmailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: Properties
    @IBOutlet weak var tagetEmail: UITextField!
    
    
    
    
    //MARK: Actions
    
    @IBAction func rateButton(_ sender: UIButton) {
        
      CurrentUser.targetEmail = tagetEmail.text
      
        
    }
    
    
    
    @IBAction func selectFromContactsButton(_ sender: Any) {
        //TODO: choose from contacts with emails
    }
}



