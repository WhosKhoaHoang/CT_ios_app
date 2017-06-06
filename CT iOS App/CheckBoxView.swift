//
//  CheckBoxView.swift
//  Checklist Demo
//
//  Created by Khoa Hoang on 6/2/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit

class CheckBoxView: UIView {

    var isChecked: Bool
    var checkBoxImageView: UIImageView
    var checkBoxChanged: () -> () = { }
    //^This is a closure...it fires everytime a checkbox is changed.
    
    
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder) //Putting super.init here leads to an error...

        self.isChecked = false
        self.checkBoxImageView = UIImageView(image: nil)
        
        super.init(coder: aDecoder)
        
        setup()
        //^Establishes the look and feel of the checkbox
    }
    
    
    func setup() {
        
        //make a border
        self.layer.borderWidth = 1.0
        self.isUserInteractionEnabled = true
        
        self.checkBoxImageView.frame = CGRect(origin: CGPoint(x: 2, y: 2), size: CGSize(width: 25, height: 25))
        self.addSubview(self.checkBoxImageView)
        
        
        let selector: Selector = #selector(CheckBoxView.checkBoxTapped)
        //checkBoxTapped is called when a checkbox is selected
        
        //register tap recognizers
        let tapRecognizer = UITapGestureRecognizer(target: self, action: selector)
        self.addGestureRecognizer(tapRecognizer)
    }
    
    
    
    func checkBoxTapped() {
        self.checkBoxChanged()
        
        if (!self.isChecked) {
            self.checkBoxImageView.image = UIImage(named: "small-check")
            self.isChecked = true
        }
        else {
            self.checkBoxImageView.image = nil
            self.isChecked = false
        }
    }
    
    
    
    func markAsChecked() {
        self.checkBoxImageView.image = UIImage(named: "small-check")
    }
    
    
    
    func markAsUnchecked() {
        self.checkBoxImageView.image = nil
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
