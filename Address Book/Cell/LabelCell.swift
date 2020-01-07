//
//  LabelCell.swift
//  AFHC
//
//  Created by Pawan kumar on 23/12/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    
    //Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
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
