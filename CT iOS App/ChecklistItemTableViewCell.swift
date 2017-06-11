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
    @IBOutlet weak var warnImage: UIImageView!
    @IBOutlet weak var checklistItemText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
