//
//  ChatListTableViewController.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit
import Firebase

enum ChatSection: Int {
    case eventChatSection = 0
    case personalChatSection
}

class ChatListTableViewController: UITableViewController {
    
    //do the search
    var searchController: UISearchController!
    var resultController = UITableViewController()
    
    var senderDisplayName: String? = "Lavender"
    
    private var personalChats: [PersonalChat] = []
    private var eventChats: [EventChat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add the search bar
        self.searchController = UISearchController(searchResultsController: self.resultController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        //load data for sample demo!
        let ZenithImage = UIImage(named: "sampleHeaderPortrait4")
        let ZenithData = UIImagePNGRepresentation(ZenithImage!) as NSData?
        let ZackImage = UIImage(named: "sampleHeaderPortrait5")
        let ZackData = UIImagePNGRepresentation(ZackImage!) as NSData?
        let KamiImage = UIImage(named: "sampleHeaderPortrait6")
        let KamiData = UIImagePNGRepresentation(KamiImage!) as NSData?
        let groupImage = UIImage(named: "Group-icon.png")
        let groupData = UIImagePNGRepresentation(groupImage!) as NSData?
        
        let Zenith = PersonalChatProfile(userId: "1", userName: "Zenith", userNickname: "Zenith", userProfileImage: ZenithData!)
        let Zack = PersonalChatProfile(userId: "2", userName: "Zack", userNickname: "Zack", userProfileImage: ZackData!)
        let Kami = PersonalChatProfile(userId: "3", userName: "Kami", userNickname: "Kami", userProfileImage: KamiData!)
        let participants = [Zenith, Zack, Kami]
        let eventChat = EventChat(participants: participants, eventName: "一起吃饭！", groupImage: groupData!, lastMessage: "Happy new year!", lastContactTime: "2:03pm")
        personalChats.append(PersonalChat(person: Zenith, lastMessage: "😀", lastContactTime: "11:53am"))
        personalChats.append(PersonalChat(person: Zack, lastMessage: "。。。", lastContactTime: "1/12"))
        personalChats.append(PersonalChat(person: Kami, lastMessage: "哦哦！", lastContactTime: "昨天"))
        eventChats.append(eventChat)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentChatSection: ChatSection = ChatSection(rawValue: section) {
            switch currentChatSection {
            case .eventChatSection:
                return eventChats.count
            case .personalChatSection:
                return personalChats.count
            }
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let reuseIdentifier = (indexPath as NSIndexPath).section == ChatSection.eventChatSection.rawValue ? "eventChatSection" : "personalChatSection"
        let reuseIdentifier = "chatCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let chatCell = cell as? ChatProfileTableViewCell {
            switch (indexPath as NSIndexPath).section {
            case ChatSection.eventChatSection.rawValue:
                chatCell.eventChat = eventChats[(indexPath as NSIndexPath).row]
            default:
                chatCell.personalChat = personalChats[(indexPath as NSIndexPath).row]
            }
        }

        return cell
    }
    
    private lazy var chatsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("chats")
    private var chatsRefHandle: FIRDatabaseHandle?
    
    // MARK: Firebase related methods
    /*private func observeChannels() {
        // Use the observe method to listen for new channels being written to the Firebase DB
        chatsRefHandle = chatsRef.observe(
            .childAdded,
            with: {
                (oneChat) -> Void in
                let chatData = oneChat.value as! Dictionary<String, AnyObject>
                let chatId = oneChat.key
                /*let profile = oneChat["snapshot"]
                if let name = oneChat["name"] as! String!, name.characters.count > 0 {
                    self.channels.append(Channel(id: id, name: name))
                    self.tableView.reloadData()
                } else {
                    print("Error! Could not decode channel data")
                }*/
            }
        )
    }*/
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let chatVC = segue.destination as! ChatUnitViewController
        chatVC.senderDisplayName = senderDisplayName
        if let channel = sender as? EventChat {
            chatVC.eventChat = channel
            //chatVC.channelRef = channelRef.child(channel.id)
        }
        if let channel = sender as? PersonalChat {
            chatVC.personalChat = channel
            //chatVC.channelRef = channelRef.child(channel.id)
        }
        //chatVC.channelRef = channelRef.child(channel.id)
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
