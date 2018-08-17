//
//  WelcomeViewController.swift
//  vici_mitch
//
//  Created by Daniel Reller on 6/18/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
 
    
    //MARK: Properties
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    //Hide nav bar
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    
    }
    
    override func viewWillDisappear(_ animated: Bool){
    //Show nav bar for login/register view
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    
    }



}
