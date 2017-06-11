//
//  ChecklistTableViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 6/10/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit
import SwiftSoup

//TODO: Parse out checklist item text from the HTML...***DONE***
//TODO: Segue from the checklists to the signature pages!

class ChecklistTableViewController: UITableViewController {

    var typeOfChecklist = ""
    var checklistItems = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //. Parse HTML here
        //. Put contents of checklist in checklist array

        
        var panelContentId: Int = Int()
        
        if (typeOfChecklist == "receive_device") {
            panelContentId = 75
        }
        else if (typeOfChecklist == "release_device") {
            panelContentId = 78
        }
        
        //Note that the URL will vary based on what checklist is being viewed!
        let url = URL(string: "http://localhost/handbook_test/public/api/panel_content/\(panelContentId)")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            //print(data) //FOR TESTING
            
            if error != nil {
                print("ERROR")
            }
            else {
                if let content = data {
                    
                    do {
                        //The following line basically says to convert the received data into an array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        
                        if let myJson = myJson[0] as? NSDictionary {
                            
                            let panelContent:String = myJson["content"] as! String
                            
                            //print(panelContent)
                            
                            let doc = try SwiftSoup.parse(panelContent)
                            
                            let checklistTextArr = try doc.select("font").array()

                            var dummy = [String]()
                            
                            for text in checklistTextArr {
                                
                                let text = try text.text()
                                let index = text.index(text.startIndex, offsetBy: 2)
                                dummy.append(text.substring(from: index))
                                
                            }
                            
                            DispatchQueue.main.async {
                                self.checklistItems = dummy
                                self.tableView.reloadData()
                                //I think this needs to be done because I think all the methods associated with building the table might finish before this asynchronous task does. As such, checklistItems would be initially empty and you'd end up with an empty tableView. However, by reloading the data, the tableView is populated with the appropriate contents.
                                
                                print(self.checklistItems) //FOR TESTING
                            }
                            
                        }
                        
                    } catch {
                        
                    }
                    
                }
            }
        }
 
        task.resume()
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        //print("Type of checklist is \(typeOfChecklist)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checklistItems.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistItem", for: indexPath) as! ChecklistItemTableViewCell

        //print(checklistItems[indexPath.row])
        
        
        // Configure the cell...
        //cell.textLabel?.text = checklistItems[indexPath.row] as! String
        cell.checklistItemText.text = checklistItems[indexPath.row]
        
        
        if (checklistItems[indexPath.row] == "Receiving Signature.") {
            cell.checkbox.removeFromSuperview()
        }
        
        /*
        if (indexPath.row == checklistItems.count-1) {
            //Take away checkbox for last row
            
            //cell.checkbox.tintColor = UIColor.purple
            //self.tableView.reloadData()
            
            cell.checkbox.removeFromSuperview()
            
            //Hmm, this is glitchy...
        }
        */
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Examine the final cell...
        if (indexPath.row == checklistItems.count-1) {
            print("LASTO!!!")
            //Perform a segue...
        }
        
    }

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
