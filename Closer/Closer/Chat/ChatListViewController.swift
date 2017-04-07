//
//  ChatListViewController.swift
//  Closer
//
//  Created by z on 2017/2/2.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

/*enum ChatSection: Int {
    case eventChatSection = 0
    case personalChatSection
}*/

class ChatListViewController: UITableViewController, UISearchResultsUpdating, UINavigationControllerDelegate, UISearchControllerDelegate, UISearchBarDelegate {
    
    let ref = FIRDatabase.database().reference()
    
    var cellId = "cellId"
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    //do the search
    let searchScopeController = AllUserViewcontroller()
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "聊天"
        //self.searchScopeController = AllUserViewcontroller()
        searchController = UISearchController(searchResultsController: searchScopeController)
        //searchScopeController.navigationController?.delegate = self
        searchScopeController.tableView.delegate = self
        searchController?.delegate = self
        tableView.tableHeaderView = self.searchController?.searchBar
        searchController?.searchResultsUpdater = self
        searchController?.dimsBackgroundDuringPresentation = true
        searchController?.searchBar.delegate = self
        definesPresentationContext = true
        
        tableView.register(ChatCell.self, forCellReuseIdentifier: cellId)
        
        observeGroupMessages()
        observeUserMessages()
        
    }
    
    /*func filterContentForSearchText(searchText: String, scope: String = "AllChats") {
        //filter
        
        //update
        tableView.reloadData()
    }*/
    
    func updateSearchResults(for searchController: UISearchController) {
        searchScopeController.searchText = searchController.searchBar.text!
        //self.navigationController?.pushViewController(searchScopeController, animated: true)
        //filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func observeGroupMessages() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        ref.child("users").child(uid).child("active-activities").observe(.childAdded, with: { (snapshot) in
            
            let groupId = snapshot.key
            
            self.ref.child("group-messages").child(groupId).observe(.childAdded, with: { (snapshot) in
                
                let messageId = snapshot.key
                    
                self.ref.child("messages").child(messageId).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: Any] {
                        let message = Message()
                        message.setValuesForKeys(dictionary)
                        message.type = "group"
                        self.messagesDictionary[groupId] = message
                        self.messages = Array(self.messagesDictionary.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            return (message1.time?.intValue)! > (message2.time?.intValue)!
                        })
                    }
                    
                }, withCancel: nil)
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    func observeUserMessages() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let userMessagesRef = FIRDatabase.database().reference().child("user-messages").child(uid)
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageId)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    
                    let message = Message()
                    message.setValuesForKeys(dictionary)
                    message.type = "personal"
                    if let partnerId = message.chatPartnerId() {
                        self.messagesDictionary[partnerId] = message
                        self.messages = Array(self.messagesDictionary.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            return (message1.time?.intValue)! > (message2.time?.intValue)!
                        })
                    }
                    
                    self.timer?.invalidate()
                    
                    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
                    
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    var timer: Timer?
    
    func handleReloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let chatCell = cell as? ChatCell {
            let message = messages[indexPath.row]
            chatCell.message = message
        }

        return cell
    }
    
    private func pushGroupChat(groupId: String, completion: @escaping (ActivityChatProfile) -> ()) {
        ref.child("activities").child(groupId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                let activityName = dictionary["name"] as? String
                let activityId = snapshot.key
                var participants = dictionary["participants"] as? [String: [String: String]]
                let userReleasingId = dictionary["releasingUserID"] as? String
                let activity = ActivityChatProfile(activityId: activityId, activityName: activityName!, participants: participants!, groupImage: "", userReleasing: userReleasingId!)
                completion(activity)
            }
            
        }, withCancel: nil)
    }
    
    private func pushPersonalChat(userId: String, completion: @escaping (PersonalUserForView) -> ()) {
        ref.child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let userName = dictionary["name"] as! String
                //let user = PersonalChatProfile(userId: snapshot.key, userName: userName, userNickname: nil, userProfileImage: "")
                let user = PersonalUserForView(userName: userName, userId: snapshot.key, gender: Gender.Female, age: 22)
                completion(user)
                if let url = dictionary["profileImageUrl"] as? String {
                    user.userProfileImageUrl = url
                }
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        if tableView === self.tableView {
            let message = messages[indexPath.row]
            let toId = (message.to)!
            switch (message.type)! {
            case "group":
                pushGroupChat(groupId: toId) {activity in
                    chatView.eventChat = activity
                    self.navigationController?.pushViewController(chatView, animated: true)
                }
            default:
                guard let partnerId = message.chatPartnerId() else {
                    return
                }
                pushPersonalChat(userId: partnerId) {user in
                    chatView.personalUser = user
                    self.navigationController?.pushViewController(chatView, animated: true)
                }
            }
            
        }
        
        else {
            switch (indexPath as NSIndexPath).section {
            case SearchSection.activities.rawValue:
                if searchScopeController.searchText != nil && searchScopeController.searchText != "" {
                    chatView.eventChat = searchScopeController.filteredActivities[(indexPath as NSIndexPath).row]
                } else {
                    chatView.eventChat = searchScopeController.activities[(indexPath as NSIndexPath).row]
                }
            case SearchSection.friends.rawValue:
                if searchScopeController.searchText != nil && searchScopeController.searchText != "" {
                    chatView.personalUser = searchScopeController.filteredFriends[(indexPath as NSIndexPath).row]
                } else {
                    chatView.personalUser = searchScopeController.friends[(indexPath as NSIndexPath).row]
                }
            case SearchSection.contacts.rawValue:
                if searchScopeController.searchText != nil && searchScopeController.searchText != "" {
                    chatView.personalUser = searchScopeController.filteredContacts[(indexPath as NSIndexPath).row]
                } else {
                    chatView.personalUser = searchScopeController.contacts[(indexPath as NSIndexPath).row]
                }
            default:
                return
            }
            self.navigationController?.pushViewController(chatView, animated: true)
        }

    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(displayP3Red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

