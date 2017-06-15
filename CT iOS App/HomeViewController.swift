//
//  HomeViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 5/27/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    let homeMenuItems = ["\tKnowledge Base",
                         "\tOpening Store Checklist",
                         "\tOffice Supplies Checklist",
                         "\tYelp Response Template",
                         "\tWorksheets",
                         "\tInventory Database",
                         "\tTechnician Policies",
                         "\tClosing Store Checklist",
                         "\tCustomer Dialogue",
                         "\tReceive Device Checklist",
                         "\tRelease Device Checklist",
                         "\tReceive Device Signature",
                         "\tRelease Device Signature"]
    
    
    var selection = ""
    
    var chosenCellName = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //This is for not displaying empty rows:
        tableView.tableFooterView = UIView(frame: .zero)

        tableView.backgroundColor = UIColor.black
        
        
        searchBar.delegate = self
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //print("HELLODE!!")
        searchBar.showsCancelButton = true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.showsCancelButton = false
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
        //So the highlight doesn't stick around
        
        
        //Instead of having segues to a bunch of different View Controllers, maybe just segue to one 
        //View Controller that takes on content particular to the cell you just tapped on?
        
        
        //Checking selections based on name is more flexible than on row number because the array elements
        //don't need to be in a specific order in order for segues to occur properly. This would make something
        //like rearranging elements in the array much easier because then you wouldn't need to also rearrange
        //the cases to conincide with the new order.
        selection = homeMenuItems[indexPath.row].trimmingCharacters(in: NSCharacterSet.whitespaces)
        
        switch (selection) {
            
            case "Knowledge Base":
                print(selection)
            case "Opening Store Checklist":
                print(selection)
            case "Office Supplies Checklist":
                print(selection)
            case "Yelp Response Template":
                print(selection)
            case "Worksheets":
                print(selection)
            case "Inventory Database":
                print(selection)
            case "Technician Policies":
                print(selection)
            case "Closing Store Checklist":
                print(selection)
            case "Customer Dialogue":
                print(selection)
            case "Receive Device Checklist", "Release Device Checklist":
                performSegue(withIdentifier: "checklistSeg", sender: indexPath) //Check
            case "Receive Device Signature":
                performSegue(withIdentifier: "receiveDevSig", sender: indexPath) //Check
            case "Release Device Signature":
                performSegue(withIdentifier: "releaseDevSig", sender: indexPath) //Check
            default:
                break
            
        }
        
    }
    

    //For adjusting height of a cell
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //===== I think this method fires before the actual segue occurs!!!! That would make sense... =====
        
        
        //If the segue identifier belongs to a segue that goes to some template view controller, then
        //pass the necessary information to that view controller so the template can be filled accordingly
        
        if (segue.identifier == "checklistSeg") {
            
            if let destVC = segue.destination as? ChecklistTableViewController {
                if (selection == "Receive Device Checklist") {
                    destVC.typeOfChecklist = "receive_device"
                }
                else if (selection == "Release Device Checklist") {
                    destVC.typeOfChecklist = "release_device"
                }
            }

            

        }
        

        
        
    }
    

}
