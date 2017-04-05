//
//  SideMenuTableViewController.swift
//  Closer
//
//  Created by Kami on 2017/1/7.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import UIKit
import Firebase

class SideMenuTableViewController: UITableViewController {
    
    let cellReuseID = "SideMenuTableViewCell"
    var targetTableViewController: DiscoverViewController?
    
//    var tableView: UITableView = UITableView()
    
    var categories = [Array<String>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func fetchCategory() {
        let dbRef = FIRDatabase.database().reference().child("categories")
        dbRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary ?? NSDictionary()
            var categorySection = [String]()
            categorySection.append("All")
            for (category, subCategories) in value {
                let cat = category as? String ?? "category-activities"
                if cat != "category-activities" {
//                    var categorySection = [String]()
//                    let subCat = subCategories as? NSDictionary ?? NSDictionary()
//                    for (subCatrgory,_) in subCat {
//                        categorySection.append(subCatrgory as! String)
//                    }
//                    self.categories.append(categorySection)
                    categorySection.append(cat)
                }
            }
            self.categories.append(categorySection)
        })
        
//        var currArray = [String]()
//        for i in 1...20 {
//            currArray.append("Category \(i)")
//        }
//        categories.append(currArray)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategory()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SideMenuCategoryTableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsMultipleSelection = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)

        if let categoryCell = cell as? SideMenuCategoryTableViewCell {
            cell.isUserInteractionEnabled = true
            categoryCell.category = categories[indexPath.section][indexPath.row]
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        targetTableViewController?.categoryFilters = [(tableView.cellForRow(at: indexPath)?.textLabel?.text)
        let currCategory = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        if (targetTableViewController?.categoryFilters.contains(currCategory))! {
        } else {
            targetTableViewController?.categoryFilters.append(currCategory)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let currCategory = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        if (targetTableViewController?.categoryFilters.contains(currCategory))! {
            targetTableViewController?.categoryFilters.remove(at: (targetTableViewController?.categoryFilters.index(of: currCategory))!)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
