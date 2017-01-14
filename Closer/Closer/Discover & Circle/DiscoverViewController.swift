//
//  DiscoverViewController.swift
//  Closer
//
//  Created by Kami on 2016/12/25.
//  Copyright © 2016年 Kami. All rights reserved.
//

import UIKit

class DiscoverViewController: CircleTableViewController {
    
    let tableHeaderView = UIView()
    
    private let buttomSize = CGSize(width: 28, height: 28)
    
    let searchResultController = CircleTableViewController()
    
    let windowWidth: CGFloat! = UIApplication.shared.keyWindow?.bounds.width
    
    var filterButton: UIButton!
    var mapButton : UIButton!
    var searchButton: UIButton!
    
    private func setupTableHeaderView() {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        tableHeaderView.backgroundColor = .white
        
        filterButton = UIButton()
        filterButton.frame = CGRect(origin: CGPoint(x: 8, y: 8), size: buttomSize)
//        filterButton.setTitle("filter", for: .normal)
//        filterButton.setTitleColor(.blue, for: .normal)
        filterButton.setImage(#imageLiteral(resourceName: "filter-icon"), for: .normal)
        filterButton.addTarget(self, action: #selector(touchFilter(_:)), for: .touchUpInside)
        tableHeaderView.addSubview(filterButton)
        
        mapButton = UIButton()
        mapButton.frame = CGRect(origin: CGPoint(x: 52, y: 8), size: buttomSize)
//        mapButton.setTitle("map", for: .normal)
//        mapButton.setTitleColor(.blue, for: .normal)
        mapButton.setImage(#imageLiteral(resourceName: "map-icon"), for: .normal)
        mapButton.addTarget(self, action: #selector(touchMap(_:)), for: .touchUpInside)
        tableHeaderView.addSubview(mapButton)
        
        searchButton = UIButton()
        searchButton.frame = CGRect(origin: CGPoint(x: windowWidth - 44, y: 8), size: buttomSize)
        searchButton.setImage(#imageLiteral(resourceName: "search-icon"), for: .normal)
        searchButton.addTarget(self, action: #selector(touchSearch(_:)), for: .touchUpInside)
        tableHeaderView.addSubview(searchButton)
        
        
//        searchController.searchBar.frame = CGRect(x: 88, y: 0, width: tableHeaderView.bounds.maxX - 88, height: 44)
//        tableHeaderView.addSubview(searchController.searchBar)
        
        tableView.tableHeaderView = tableHeaderView
    }
    
    var searchController: ActivitySearchController!

    @IBOutlet weak var activitySearchBar: UISearchBar!
    
    let sideMenuLauncher = SideMenuLauncher()
    
    let mapViewController = MapViewController()
    
    @IBAction func touchFilter(_ sender: UIButton) {
        sideMenuLauncher.prepareForView()
        sideMenuLauncher.menuWillShow()
    }
        
    @IBAction func touchMap(_ sender: UIButton) {
        mapViewController.location = "UCLA"
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func touchSearch(_ sender: UIButton) {
        setupSearchController()
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    
    private func setupSearchController() {
        searchController = ActivitySearchController()
    }
    
    var discoverTableViewController = CircleTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableHeaderView()
//        tableView.delegate = discoverTableViewController
//        tableView.dataSource = discoverTableViewController
//        tableView.register(CircleTableViewCell.self, forCellReuseIdentifier: CircleTableViewController.cellReuseID)
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableViewAutomaticDimension
//        discoverTableViewController.searchText = "default"
        searchText = "default"
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show Map" {
//            if let dvc = segue.destination.presentingViewController {
//                
//            }
        }
        
    }

}
