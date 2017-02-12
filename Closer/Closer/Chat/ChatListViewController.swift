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

class ChatListViewController: UITableViewController, UISearchResultsUpdating {
    
    var cellId = "cellId"
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    //do the search
    var searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText(searchText: String, scope: String = "AllChats") {
        //filter
        
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
        
        //observeMessages()
        observeUserMessages()
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
                    
                    if let partnerId = message.chatPartnerId() {
                        self.messagesDictionary[partnerId] = message
                        self.messages = Array(self.messagesDictionary.values)
                        self.messages.sort(by: { (message1, message2) -> Bool in
                            return (message1.time?.intValue)! > (message2.time?.intValue)!
                        })
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    func observeMessages() {
        let messagesRef = FIRDatabase.database().reference().child("messages")
        messagesRef.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                let message = Message()
                //message.time = dictionary["time"] as! Date? as NSDate?
                message.setValuesForKeys(dictionary)
                //self.messages.append(message)
                if let toId = message.to {
                    self.messagesDictionary[toId] = message
                    self.messages = Array(self.messagesDictionary.values)
                    self.messages.sort(by: { (message1, message2) -> Bool in
                        return (message1.time?.intValue)! > (message2.time?.intValue)!
                    })
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }, withCancel: nil)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let message = messages[indexPath.row]
        guard let partnerId = message.chatPartnerId() else {
            return
        }
        let userRef = FIRDatabase.database().reference().child("users").child(partnerId)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let userName = dictionary["name"] as! String
                let user = PersonalChatProfile(userId: snapshot.key, userName: userName, userNickname: nil, userProfileImage: "")
                chatView.personalUser = user
                self.navigationController?.pushViewController(chatView, animated: true)
            }
        }, withCancel: nil)

    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(displayP3Red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

