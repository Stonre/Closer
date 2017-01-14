//
//  ActivitySearchViewController.swift
//  Closer
//
//  Created by Kami on 2017/1/10.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import UIKit

class ActivitySearchController: CircleTableViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    
    let windowWidth: CGFloat! = UIApplication.shared.keyWindow?.frame.width
    var resultView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        navigationController?.hidesBarsOnTap = true
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.delegate = self
        
        view.backgroundColor = .white
        title = "活动搜索"
        
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: windowWidth, height: 44)
        searchController.searchBar.placeholder = "活动搜索"
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitleCell")
        
        let currAcvitity = activities[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = currAcvitity.name
        cell.detailTextLabel?.text = currAcvitity.description.text
        
        return cell
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

extension ActivitySearchController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchText = searchController.searchBar.text!.lowercased()
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        print("willPresent")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        searchText = "default"
    }
}


