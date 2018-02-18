//
//  ActiveListCell.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 2/16/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit

class ActiveListCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    func setupView(item:Item){
        if item.activeList == true {
           self.itemLabel.text = item.name
        }
    }
    
    
   
}
