//
//  ChecklistItemTableViewCell.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 6/10/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit

class ChecklistItemTableViewCell: UITableViewCell {

    @IBOutlet weak var checkbox: UIView!
    @IBOutlet weak var checklistItemText: UILabel!
    
    @IBOutlet weak var warn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure() {
        
        /*
        //This if/else needs to be here to make sure that re-used cells aren't checked?
        if (self.isSelected) {
            self.checkbox!.markAsChecked()
        }
        else {
            self.checkbox!.markAsUnchecked()
        }
        
        self.name?.text = customer.name
        
        
        //Define the checkBoxChanged closure
        self.checkbox?.checkBoxChanged = {
            
            //Why did we need a closure? Why not just include this if-else block by itself?
            
            //The checkBox has changed state, so if customer is not selected, mark it as selected.
            if (!customer.isSelected) {
                self.checkbox!.markAsChecked()
                self.isSelected = true
            }
            else {
                self.checkbox!.markAsUnchecked()
                self.isSelected = false
            }
        }
        */
        
        
    }

}
