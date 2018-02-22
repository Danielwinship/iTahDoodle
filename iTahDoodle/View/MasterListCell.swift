//
//  MasterListCell.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 2/16/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class MasterListCell: UITableViewCell {

    //Outlets

    @IBOutlet weak var itemLabel: UILabel!
    
    
    func setupView(item:Item){
        itemLabel.text = item.name
        //item.activeList = true
    }
    
    
}
