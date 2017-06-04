//
//  ReceiveDeviceViewViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 6/3/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit
import SwiftSignatureView


//I think this can actually be a superclass...
//Instance variables would be as they are below...you'd just control drag from a View Controller?

class ReceiveDeviceViewController: UIViewController, SwiftSignatureViewDelegate {
    
    @IBOutlet weak var workOrderNumInput: UITextField!
    @IBOutlet weak var cb1: CheckBoxView!
    @IBOutlet weak var cb2: CheckBoxView!
    @IBOutlet weak var cb3: CheckBoxView!
    @IBOutlet weak var custNameInput: UITextField!
    @IBOutlet weak var signature: SwiftSignatureView!
    @IBOutlet weak var receivedByInput: UITextField!
    @IBOutlet weak var sigDatePicker: UIDatePicker!
    @IBOutlet weak var theContent: UIView!
    //^This is for the PDF
    @IBOutlet weak var submitBtn: UIButton!
    
    
    @IBAction func submit(_ sender: Any) {

        let errorMsg: String = validateSigPage()
        
        if (errorMsg != "") {
            createAlert(titleText: "Error", msgText: errorMsg)
        }
        else {
            print("TO THE DROPBOX!")
        }
        
    }
    
    
    func validateSigPage()->String {
        
        var errorMsg: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        
        let sigDate = dateFormatter.string(from: sigDatePicker.date)
        let curDate = dateFormatter.string(from: Date())
        
        if (workOrderNumInput.text == "") {
            errorMsg += ". Please enter a Work Order #\n"
        }

        if (!cb1.isChecked || !cb2.isChecked || !cb3.isChecked) {
            errorMsg += ". Please agree to all the terms\n"
        }
        
        if (custNameInput.text == "") {
            errorMsg += ". Please enter customer's name\n"
        }
        
        if (signature.signature == nil) {
            errorMsg += ". Please provide customer's signature\n"
        }
        
        if (receivedByInput.text == "") {
            errorMsg += ". Please specify who received the signature\n"
        }
        
        if (sigDate != curDate) {
            errorMsg += ". Please enter today's date\n"
        }
     
        return errorMsg
        
    }
    
    
    func createAlert(titleText: String, msgText: String) {
        
        let alert = UIAlertController(title: titleText, message: msgText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        submitBtn.layer.cornerRadius = 5
        //submitBtn.layer.borderWidth = 1
        //submitBtn.layer.borderColor = UIColor.black.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Delegate
    public func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        //print("Did tap inside")
    }
    
    
    public func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView) {
        //print("Did pan inside")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
