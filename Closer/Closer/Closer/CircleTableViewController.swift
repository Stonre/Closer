//
//  CircleTableTableViewController.swift
//  Closer
//
//  Created by Kami on 2017/1/6.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import UIKit

class CircleTableViewController: UITableViewController {
    
    static let cellReuseID = "CircleTableCell"

    var activities = [Array<Activity>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? {
        didSet {
            activities.removeAll()
            searchForActivities()
        }
    }
    
    private func searchForActivities() {
        if searchText == "default" {
            var defaultSection = [Activity]()
            for i in 1...10 {
                var description = ""
                for _ in 1...i{
                    description += "This is Activity \(i) \n"
                }
                defaultSection.append(GeneralActivity(name: "Activity \(i)", tags: [], authority: Authority.FriendsAndContacts, description: Description(txt: description), userReleasing: PersonalUserForView(userName: "User \(i)", userId: 0, gender: Gender.Female, age: 18)))
            }
            activities.append(defaultSection)
        }
    }
    
    private func fetchActivities() {
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.estimatedRowHeight = 120
//        tableView.rowHeight = UITableViewAutomaticDimension
        searchText = "default"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
            return activities.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewController.cellReuseID, for: indexPath)

        let currAcvitity = activities[indexPath.section][indexPath.row]
        if let activityCell = cell as? CircleTableViewCell {
            activityCell.activity = currAcvitity
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
