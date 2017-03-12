//
//  AllUserViewcontroller.swift
//  Closer
//
//  Created by z on 2017/2/2.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

enum SearchSection: Int {
    case activities = 0
    case friends
    case contacts
}

let sectionTitle: [Int: String] = [0: "任务", 1: "好友", 2: "联系人"]

class AllUserViewcontroller: UITableViewController, UINavigationControllerDelegate {
    
    var cellId = "cellId"
    var searchText: String? {
        didSet {
            if let text = searchText {
                updateSearchResults(searchText: text)
            }
        }
    }
    
    //do the search
    //var searchController = UISearchController(searchResultsController: nil)
    
    var friends = [PersonalUserForView]()
    var contacts = [PersonalUserForView]()
    var activities = [ActivityChatProfile]()
    var filteredFriends = [PersonalUserForView]()
    var filteredContacts = [PersonalUserForView]()
    var filteredActivities = [ActivityChatProfile]()
    
    func filterContentForSearchText(searchText: String, scope: String = "AllChats") {
        //filter
        filteredFriends = friends.filter({ (friend: PersonalUserForView) -> Bool in
            return (friend.userName.contains(searchText))
        })
        
        filteredContacts = contacts.filter({ (contact: PersonalUserForView) -> Bool in
            return (contact.userName.contains(searchText))
        })
        
        filteredActivities = activities.filter({ (activity: ActivityChatProfile) -> Bool in
            return activity.activityName.contains(searchText)
        })
        
        //update
        tableView.reloadData()
    }
    
    func updateSearchResults(searchText: String) {
        filterContentForSearchText(searchText: searchText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.tableHeaderView = self.searchController.searchBar
        //searchController.searchResultsUpdater = self
        //searchController.dimsBackgroundDuringPresentation = false
        //definesPresentationContext = true
        self.tableView.delegate = self
        self.navigationController?.delegate = self
        self.navigationItem.title = "搜索"
        
        tableView.register(OtherUserTableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchPersonalUser()
        fetchActiveEvents()
    }
    
    func fetchPersonalUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                if let name = dictionary["name"] as? String {
                    let user = PersonalUserForView(userName: name, userId: snapshot.key, gender: Gender.Female, age: 22)
                    
                    if let url = dictionary["profileImageUrl"] as? String {
                        user.userProfileImageUrl = url
                    }
                    self.friends.append(user)
                    self.contacts.append(user)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, withCancel: nil)

    }
    
    func fetchActiveEvents() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).child("active-activities").observe(.childAdded, with: { (snapshot) in
            
            let activityId = snapshot.key
            let activityRef = FIRDatabase.database().reference().child("activities").child(activityId)
                activityRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    
                    let name = dictionary["name"] as! String
                    var participants = [String]()
                    //let participants = dictionary["participants"] as! [String]
                    let userReleasingId = dictionary["releasingUserID"] as! String
                    
                    activityRef.child("participants").observe(.childAdded, with: { (snapshot) in
                        
                        participants.append(snapshot.key)
                        
                    }, withCancel: nil)
                    FIRDatabase.database().reference().child("users").child(userReleasingId).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        if let dictionary = snapshot.value as? [String: Any] {
                            let userName = dictionary["name"] as! String
                            let user = PersonalUserForView(userName: userName, userId: snapshot.key, gender: Gender.Female, age: 22)
                            
                            let activity = ActivityChatProfile(activityId: activityId, activityName: name, participants: participants, groupImage: "", userReleasing: user)
                            
                            if let url = dictionary["profileImageUrl"] as? String {
                                user.userProfileImageUrl = url
                            }
                            
                            self.activities.append(activity)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                        }, withCancel: nil)
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let currentSection: SearchSection = SearchSection(rawValue: section) {
            switch currentSection {
            case .friends:
                return searchText != nil && searchText != "" ? filteredFriends.count : friends.count
            case .contacts:
                return searchText != nil && searchText != "" ? filteredContacts.count : contacts.count
            case .activities:
                return searchText != nil && searchText != "" ? filteredActivities.count : activities.count
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
        
        if let searchCell = cell as? OtherUserTableViewCell {
            switch (indexPath as NSIndexPath).section {
            case SearchSection.activities.rawValue:
                if searchText != nil && searchText != "" {
                    searchCell.activity = filteredActivities[(indexPath as NSIndexPath).row]
                } else {
                    searchCell.activity = activities[(indexPath as NSIndexPath).row]
                }
            case SearchSection.friends.rawValue:
                if searchText != nil && searchText != "" {
                    searchCell.user = filteredFriends[(indexPath as NSIndexPath).row]
                } else {
                    searchCell.user = friends[(indexPath as NSIndexPath).row]
                }
            case SearchSection.contacts.rawValue:
                if searchText != nil && searchText != "" {
                    searchCell.user = filteredContacts[(indexPath as NSIndexPath).row]
                } else {
                    searchCell.user = contacts[(indexPath as NSIndexPath).row]
                }
            default:
                return cell
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        switch (indexPath as NSIndexPath).section {
        case SearchSection.activities.rawValue:
            if searchText != nil && searchText != "" {
                chatView.eventChat = filteredActivities[(indexPath as NSIndexPath).row]
            } else {
                chatView.eventChat = activities[(indexPath as NSIndexPath).row]
            }
        case SearchSection.friends.rawValue:
            if searchText != nil && searchText != "" {
                chatView.personalUser = filteredFriends[(indexPath as NSIndexPath).row]
            } else {
                chatView.personalUser = friends[(indexPath as NSIndexPath).row]
            }
        case SearchSection.contacts.rawValue:
            if searchText != nil && searchText != "" {
                chatView.personalUser = filteredContacts[(indexPath as NSIndexPath).row]
            } else {
                chatView.personalUser = contacts[(indexPath as NSIndexPath).row]
            }
        default:
            return
        }
        self.navigationController?.pushViewController(chatView, animated: true)
    }

}

