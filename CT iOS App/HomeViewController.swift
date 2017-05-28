//
//  HomeViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 5/27/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
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
        
        return cell
    }
    
    
    //When user selects a row
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(homeMenuItems[indexPath.row])
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
