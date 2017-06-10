//
//  ProfileViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 5/28/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let profileMenuItems = ["\tOpening Store Checklist",
                         "\tShipping Procedure",
                         "\tSmart Pick-Up Procedure",
                         "\tOnsite Phone Repair",
                         "\tCustomer Procedures",
                         "\tPurchasing Procedure",
                         "\tInventory Top Off Procedure",
                         "\tOffice Supply Checklist",
                         "\tOnline Marketing",
                         "\tWorksheets"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //This is for not displaying empty rows:
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = UIColor.black
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    //Specify number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    
    //Specify number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profileMenuItems.count
    }
    
    
    
    //Configure each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileItem", for: indexPath)
        
        
        cell.textLabel?.text = profileMenuItems[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = UIColor.green
        
        cell.backgroundColor = UIColor.black
        
        //For having dividers span whole screen
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }

    
    //When user selects a row
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //For adjusting height of a cell
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
