//
//  MyTableViewMyActivitiesCell.swift
//  fisu
//
//  Created by vm mac on 17/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import UIKit

class MyTableViewMyActivitiesCell: UITableViewCell {
    
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    @IBOutlet weak var myTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
