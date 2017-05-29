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
                         "Customer Dialogue"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //This is for not displaying empty rows:
        tableView.tableFooterView = UIView(frame: .zero)

        tableView.backgroundColor = UIColor.black
        
        print("LOADED HOMEVIEW")
        
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
        cell.textLabel?.textAlignment = .center
        
        cell.textLabel?.textColor = UIColor.green
        
        cell.backgroundColor = UIColor.black
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        
        
        return cell
    }
    
    
    //When user selects a row
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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
            performSegue(withIdentifier: "closeStoreClSeg", sender: indexPath)
        case 9:
            performSegue(withIdentifier: "custDiaSeg", sender: indexPath)
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