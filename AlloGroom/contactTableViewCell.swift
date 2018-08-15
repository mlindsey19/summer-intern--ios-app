//
//  contactTableViewCell.swift
//  AlloGroom
//
//  Created by Daniel Reller on 8/15/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import UIKit

class contactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
