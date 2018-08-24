//
//  RatingViewController.swift
//  AlloGroom
//
//  Created by Daniel Reller on 8/14/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit
import Alamofire

class RatingTableViewController: UITableViewController {
    
    //MARK: Properties
    @IBOutlet weak var traitNameLabel: UILabel!
    @IBOutlet weak var targetEmailLabel: UILabel!
    @IBOutlet weak var rating: RatingControl!
    
    //trait array
    var traits = [TraitStruct]()
    
    //rating keys
    let ratingkey = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //remove emptry cells under button
        self.tableView.tableFooterView = UIView()

        
//
        targetEmailLabel.text = CurrentUser.targetEmail

        fetchTraits{
            //reload data after fetched on main thread
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rateButton(_ sender: Any) {
        //set parameters
        let parameters: Parameters = [
            Keys.targetEmail: CurrentUser.targetEmail!,
            Keys.userEmail: CurrentUser.email!,
            Keys.ratingKey: ratingkey,
            Keys.ratingValue: rating.rating
            
        ]
        //send post
        Alamofire.request(URL.addToRatingTable, method: .post, parameters: parameters).responseJSON { response in
            print(response.result)  // result of response serializaion
            
            guard let data = response.data else {print("data var not initilized correctly"); return}
            let decoder = JSONDecoder()
            guard (try? decoder.decode(JSONResponseStruct.self, from: data)) != nil
                else {print("did not parse correctly")
                    return
            }
            //
            
            
        }
        
        
    }
    
    
}