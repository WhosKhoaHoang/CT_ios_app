//
//  ReceiveDeviceViewViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 6/3/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit
import SwiftSignatureView
import SwiftyDropbox

//I think this can actually be a superclass...
//Instance variables would be as they are below...you'd just control drag from a View Controller?
class SignaturePageViewController: UIViewController, SwiftSignatureViewDelegate {
    
    @IBOutlet weak var workOrderNumInput: UITextField!
    @IBOutlet weak var cb1: CheckBoxView!
    @IBOutlet weak var cb2: CheckBoxView!
    @IBOutlet weak var cb3: CheckBoxView!
    @IBOutlet weak var custNameInput: UITextField!
    
    @IBOutlet weak var signature: SwiftSignatureView!
    
    @IBOutlet weak var recOrRelByInput: UITextField!
    @IBOutlet weak var sigDatePicker: UIDatePicker!
    //^Weird...the date picker isn't displaying properly in the PDF...DELETE THIS!!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    @IBOutlet weak var theContent: UIView!
    //^This is for the PDF
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var authorizeBtn: UIButton!
    
    
    
    @IBAction func authorizeDropbox(_ sender: Any) {
        
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.open(url)
        })
        
    }
    
    
    
    
    @IBAction func submit(_ sender: Any) {
        
        
        //createAlert(titleText: "Success!", msgText: "Signature page has been seent to Dropbox.")
        
        let errorMsg: String = validateSigPage()
        if (errorMsg != "") {
            createAlert(titleText: "Error", msgText: errorMsg)
        }
        else {
            let pdfData: Data = makePdfOfCurrentPage()
            //uploadPageToDropbox(data: pdfData, workOrderNum: "123") //HARD-CODED WORK ORDER NUMBER
            uploadPageToDropbox(data: pdfData, workOrderNum: workOrderNumInput.text!)
            
            createAlert(titleText: "Success", msgText: "Signature page has been sent to Dropbox.")
        }
    }
    
    
    
    func makePdfOfCurrentPage()->Data {
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, theContent.bounds, nil)
        UIGraphicsBeginPDFPage()
        
        //guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        let pdfContext = UIGraphicsGetCurrentContext()
        
        theContent.layer.render(in: pdfContext!)
        UIGraphicsEndPDFContext()
        
        return pdfData as Data
    }
    
    
    
    func clearPage() {
        workOrderNumInput.text = ""
        cb1.markAsUnchecked()
        cb2.markAsUnchecked()
        cb3.markAsUnchecked()
        custNameInput.text = ""
        signature.clear()
        recOrRelByInput.text = ""
    }
    
    func uploadPageToDropbox(data: Data, workOrderNum: String) {
        
        let client = DropboxClientsManager.authorizedClient
        let request = client?.files.upload(path: "/" + self.restorationIdentifier! + "_work_order" + workOrderNum + ".pdf", input: data as Data)
            .response { response, error in
                if let response = response {
                    print("MADE IT!")
                    print(response)
                } else if let error = error {
                    print("ERROR!")
                    print(error)
                }
            }
            .progress { progressData in
                print(progressData)
        }
    }
    
    
    
    func validateSigPage()->String {
        
        var errorMsg: String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        
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
        
        if (recOrRelByInput.text == "") {
            
            if (self.restorationIdentifier == "receive_sig") {
            
            errorMsg += ". Please specify who received the device\n"
            }
            else if (self.restorationIdentifier == "release_sig") {
                
                errorMsg += ". Please specify who released the device\n"
                
            }
        }
     
        return errorMsg
        
    }
    
    
    
    func createAlert(titleText: String, msgText: String) {
        
        let alert = UIAlertController(title: titleText, message: msgText, preferredStyle: .alert)
        
        
        if (titleText == "Error") {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
        }
        else if (titleText == "Success") {
            alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { (action) in self.navigationController?.popViewController(animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Clear Page", style: .default, handler: { (action) in self.clearPage()
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /*
    func createAlertFromSubmit(titleText: String, msgText: String) {
        
        let alert = UIAlertController(title: titleText, message: msgText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { (action) in self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Clear Page", style: .default, handler: { (action) in self.clearPage()
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        submitBtn.layer.cornerRadius = 5
        //submitBtn.layer.borderWidth = 1
        //submitBtn.layer.borderColor = UIColor.black.cgColor
        
        authorizeBtn.layer.cornerRadius = 5
        
        //cb1.layer.borderWidth = 1
        
        
        //Fill out today's date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M / d / yy"

        let curDate = dateFormatter.string(from: Date())
        
        dateLabel.text = curDate
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
