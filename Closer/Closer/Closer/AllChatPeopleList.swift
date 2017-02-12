//
//  ChatListViewController.swift
//  Closer
//
//  Created by z on 2017/2/2.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

enum ChatSection: Int {
    case eventChatSection = 0
    case personalChatSection
}

class ChatListViewController: UITableViewController, UISearchResultsUpdating {
    
    var cellId = "cellId"
    
    //do the search
    var searchController = UISearchController(searchResultsController: nil)
    
    var personalChats: [PersonalChat] = []
    var eventChats: [EventChat] = []
    var filteredPersonalChats = [PersonalChat]()
    var filteredEventChats = [EventChat]()
    
    func filterContentForSearchText(searchText: String, scope: String = "AllChats") {
        //filter
        filteredPersonalChats = personalChats.filter({ (personalChat: PersonalChat) -> Bool in
            return (personalChat.person.displayName?.contains(searchText))!
        })
        
        filteredEventChats = eventChats.filter({ (eventChat: EventChat) -> Bool in
            return eventChat.eventName.contains(searchText)
        })
        
        //update
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = self.searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        self.navigationItem.title = "聊天"
        
        tableView.register(ChatCell.self, forCellReuseIdentifier: cellId)
        
        fetchPersonalUser()
    }
    
    func fetchPersonalUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let name = snapshot.childSnapshot(forPath: "name").value as? String {
                let user = PersonalChatProfile(userId: snapshot.key, userName: name, userNickname: name, userProfileImage: "")
                let chat = PersonalChat(person: user, lastMessage: "message", lastContactTime: "time")
                self.personalChats.append(chat)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let currentChatSection: ChatSection = ChatSection(rawValue: section) {
            switch currentChatSection {
            case .eventChatSection:
                return searchController.isActive && searchController.searchBar.text != "" ? filteredEventChats.count : eventChats.count
            case .personalChatSection:
                return searchController.isActive && searchController.searchBar.text != "" ? filteredPersonalChats.count : personalChats.count
                // searchController.searchBar.text != ""
            }
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let chatCell = cell as? ChatCell {
            switch (indexPath as NSIndexPath).section {
            case ChatSection.eventChatSection.rawValue:
                if searchController.isActive && searchController.searchBar.text != "" {
                    chatCell.eventChat = filteredEventChats[(indexPath as NSIndexPath).row]
                } else {
                    chatCell.eventChat = eventChats[(indexPath as NSIndexPath).row]
                }
            default:
                if searchController.isActive && searchController.searchBar.text != "" {
                    chatCell.personalChat = filteredPersonalChats[(indexPath as NSIndexPath).row]
                } else {
                    chatCell.personalChat = personalChats[(indexPath as NSIndexPath).row]
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        switch (indexPath as NSIndexPath).section {
        case ChatSection.eventChatSection.rawValue:
            if searchController.isActive && searchController.searchBar.text != "" {
                chatView.eventChat = filteredEventChats[(indexPath as NSIndexPath).row]
            } else {
                chatView.eventChat = eventChats[(indexPath as NSIndexPath).row]
            }
        default:
            if searchController.isActive && searchController.searchBar.text != "" {
                chatView.personalUser = filteredPersonalChats[(indexPath as NSIndexPath).row].person
            } else {
                chatView.personalUser = personalChats[(indexPath as NSIndexPath).row].person
            }
        }
        self.navigationController?.pushViewController(chatView, animated: true)
    }
    
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(displayP3Red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

