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
    @IBOutlet weak var theContent: UIView!
    //^This is for the PDF
    
    @IBAction func submit(_ sender: Any) {
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Don't need this
    /*
     //For if you have a clear button. Be sure to clear the SignatureVIew after submitting!
     @IBAction func didTapClear() {
     signatureView.clear()
     }
     */
    
    
    //MARK: Delegate
    public func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        print("Did tap inside")
    }
    
    
    public func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView) {
        print("Did pan inside")
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
