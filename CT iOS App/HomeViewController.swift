//
//  HomeViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 5/27/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let homeMenuItems = ["Knowledge Base",
                         "Drop-Off Signature",
                         "Opening Store Checklist",
                         "Office Supplies Checklist",
                         "Yelp Response Template",
                         "Worksheets",
                         "Inventory Database",
                         "Technician Policies",
                         "Closing Store Checklist",
                         "Customer Dialogue",
                         "Receive Device Checklist",]
    
    
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
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeMenuItems.count
    }
    
    
    //Configure each cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeItem", for: indexPath)
        
        cell.textLabel?.text = homeMenuItems[indexPath.row]
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
        
        //Might wanna find a better way to handle these segues. I.e., instead of having segues to a bunch of different 
        //View Controllers, maybe just segue to one View Controller that takes on content particular to the cell you 
        //just tapped on?
        switch (indexPath.row) {
        case 0:
            performSegue(withIdentifier: "kbSeg", sender: indexPath)
        case 1:
            performSegue(withIdentifier: "doSigSeg", sender: indexPath)
        case 2:
            performSegue(withIdentifier: "openStoreCLSeg", sender: indexPath)
        case 3:
            performSegue(withIdentifier: "officeSupCLSeg", sender: indexPath)
        case 4:
            performSegue(withIdentifier: "yelpRespSeg", sender: indexPath)
        case 5:
            performSegue(withIdentifier: "worksheetsSeg", sender: indexPath)
        case 6:
            performSegue(withIdentifier: "invenDbSeg", sender: indexPath)
        case 7:
            performSegue(withIdentifier: "techPolSeg", sender: indexPath)
        case 8:
            performSegue(withIdentifier: "closeStoreCLSeg", sender: indexPath)
        case 9:
            performSegue(withIdentifier: "custDiaSeg", sender: indexPath)
        case 10:
            performSegue(withIdentifier: "receiveDevSig", sender: indexPath)
        default:
            break
        }
        
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
