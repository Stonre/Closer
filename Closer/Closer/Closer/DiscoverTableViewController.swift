//
//  DiscoverViewController.swift
//  Closer
//
//  Created by Kami on 2016/12/25.
//  Copyright © 2016年 Kami. All rights reserved.
//

import UIKit

class DiscoverTableViewController: CircleTableViewController {

//    @IBOutlet weak var activityTableView: UITableView!

//    @IBAction func touchFilter(_ sender: UIButton) {
//    }
//    
//    @IBAction func touchMap(_ sender: UIButton) {
//    }
    
    var discoverTableViewController = CircleTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        searchText = "default"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        discoverTableViewController.searchText = "default"
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
