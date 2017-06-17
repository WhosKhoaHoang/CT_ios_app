//
//  InventoryViewController.swift
//  CT iOS App
//
//  Created by Khoa Hoang on 6/17/17.
//  Copyright © 2017 KhoaHoang. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = ["dogs", "Cats", "Goofs", "Apples", "Frogs", "Orange"]
    //data is the set of all your data
    
    var filteredData = [String]()
    //filteredData will be a subset of all your data/your search results
    
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.returnKeyType = UIReturnKeyType.done
        
        //print("HEY I LOADED") //FOR TESTING
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (inSearchMode) {
            return filteredData.count
        }
        
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryItemCell", for: indexPath) as? DataCell {
            
            let text: String!
            
            if (inSearchMode) {
                text = filteredData[indexPath.row]
            }
            else {
                text = data[indexPath.row]
            }
            
            cell.configureCell(text: text)
            
            return cell
        }
        else {
            return UITableViewCell()
        }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar.text == nil || searchBar.text == "") {
            
            inSearchMode = false
            
            view.endEditing(true)
            
            tableView.reloadData()
            
        } else {
            
            inSearchMode = true
            
            filteredData = data.filter({$0 == searchBar.text})
            //filter takes a closure, which is like a lambda function?
            
            tableView.reloadData()
            
            //print("SEARCHING STUFF") //FOR TESTING
        }
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
