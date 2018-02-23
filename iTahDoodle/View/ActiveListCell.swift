//
//  ActiveListCell.swift
//  iTahDoodle
//
//  Created by Daniel Winship on 2/16/18.
//  Copyright © 2018 Daniel Winship. All rights reserved.
//

import UIKit
import CoreData

class ActiveListCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
   
    
    func setupView(itemName: String, itemActive: Bool){
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: itemName)

        if itemActive == true {
            
        self.itemLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString.length))
         itemLabel.attributedText = attributeString
            
            
        } else {
            self.itemLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
             attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
              self.itemLabel.attributedText = attributeString
        }
    }
    
    
   
}
