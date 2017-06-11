//
//  ChecklistTableViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 6/10/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit
import SwiftSoup

class ChecklistTableViewController: UITableViewController {

    var typeOfChecklist = ""
    var checkListItems = [Any]()
    //var arr = ["a", "b", "c"]
    
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //. Parse HTML here
        //. Put contents of checklist in checklist array

        
        let url = URL(string: "http://localhost/handbook_test/public/api/panel_content/75") //FOR TESTING
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            print(data) //FOR TESTING
            
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
                            
                            print(panelContent)
                            
                            let doc = try SwiftSoup.parse(panelContent)

                            
                            //Parse the checklist items and append them to checkListItems...would I need to use DispatchQueue?
                            
                            /*
                            DispatchQueue.main.async {
                                let attrStr = try! NSAttributedString(
                                    data: myStr.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                    options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                    documentAttributes: nil)
                                
                                //self.tv.attributedText = attrStr
                            }
                            */
                        }
                        
                    } catch {
                        
                    }
                    
                }
            }
        }
        
        task.resume()
        
        //FOR TESTING
        checkListItems.append("A")
        checkListItems.append("B")
        
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
        return checkListItems.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistItem", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = checkListItems[indexPath.row] as! String

        

        return cell
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
