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

//For checking if connected to Internet...
import Foundation
import SystemConfiguration


class SignaturePageViewController: UIViewController, SwiftSignatureViewDelegate {
    
    @IBOutlet weak var theContent: UIView!
    //^This is for the PDF
    
    @IBOutlet weak var workOrderNumInput: UITextField!
    @IBOutlet weak var cb1: CheckBoxView!
    @IBOutlet weak var cb2: CheckBoxView!
    @IBOutlet weak var cb3: CheckBoxView!
    @IBOutlet weak var custNameInput: UITextField!
    @IBOutlet weak var signature: SwiftSignatureView!
    @IBOutlet weak var recOrRelByInput: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var loginToDropboxPrompt: UIView!
    @IBOutlet weak var loginAuthorizeDropboxLabel: UILabel!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (DropboxClientsManager.authorizedClient == nil) {
            submitBtn.isEnabled = false
            submitBtn.alpha = 0.5
            
        }
        else {
            submitBtn.isEnabled = true
            submitBtn.alpha = 1.0
            loginToDropboxPrompt.isHidden = true
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func submit(_ sender: Any) {

        let errorMsg: String = validateSigPage()
        if (errorMsg != "") {
            createAlert(titleText: "Form Error", msgText: errorMsg)
        }
        else {
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            let pdfData: Data = makePdfOfCurrentPage()
            //uploadPageToDropbox(data: pdfData, workOrderNum: "123") //HARD-CODED WORK ORDER NUMBER
            uploadPageToDropbox(data: pdfData, workOrderNum: workOrderNumInput.text!)
            
            
            //createAlert(titleText: "Success", msgText: "Signature page has been sent to Dropbox.")
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
        
        var folderName = self.restorationIdentifier == "release_sig" ? "Release Device Signatures" : "Receive Device Signatures"
        
        let request = client?.files.upload(path: "/"+folderName+"/" + self.restorationIdentifier! + "_work_order" + workOrderNum + ".pdf", input: data as Data)
            .response { response, error in
                if let response = response {
                    //print(response)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.createAlert(titleText: "Success", msgText: "Signature page has been sent to Dropbox.")
                    }
                    
                } else if let error = error {
                    //print(error)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.createAlert(titleText: "Client Error", msgText: "Please re-authenticate the Dropbox connection.")
                    }
                }
            }
            .progress { progressData in
                print(progressData)
        }
        
    }
    
    
    
    func validateSigPage()->String {
        
        var errorMsg: String = ""
        
        
        if (!isInternetAvailable()) {
            errorMsg += "Please connect to the Internet."
        }
        else {
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
        }
        return errorMsg
        
    }
    
    
    
    func createAlert(titleText: String, msgText: String) {
        
        let alert = UIAlertController(title: titleText, message: msgText, preferredStyle: .alert)
        
        
        if (titleText == "Client Error") {
            alert.addAction(UIAlertAction(title: "Reauthenticate", style: .default, handler: { (action) in self.openDropboxLoginAuth()
            }))
        }
        else if (titleText == "Form Error") {
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
    
    

    func loginAuthorizeDropbox(sender:UITapGestureRecognizer) {
        //print("tap working")
        openDropboxLoginAuth()
    }
    
    
    
    func openDropboxLoginAuth() {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        if #available(iOS 10.0, *) {
                                                            UIApplication.shared.open(url)
                                                        } else {
                                                            UIApplication.shared.openURL(url)
                                                        }
        })
    }

    
    
    //From https://stackoverflow.com/questions/39558868/check-internet-connection-ios-10
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        submitBtn.layer.cornerRadius = 5
        //submitBtn.layer.borderWidth = 1
        
        //Fill out today's date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M / d / yy"
        let curDate = dateFormatter.string(from: Date())
        dateLabel.text = curDate
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.loginAuthorizeDropbox))
        loginAuthorizeDropboxLabel.isUserInteractionEnabled = true
        loginAuthorizeDropboxLabel.addGestureRecognizer(tap)
        
        activityIndicator.isHidden = true
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
