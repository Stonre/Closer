//
//  ChatProfileTableViewCell.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit

class ChatProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var lastChatTime: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    var personalChat: PersonalChat? {
        didSet {
            updatePersonalChatUI()
        }
    }
    
    var eventChat: EventChat? {
        didSet {
            updateEventChatUI()
        }
    }
    
    private func updatePersonalChatUI() {
        lastChatTime.text = personalChat?.lastContactTime
        lastMessage.text = personalChat?.lastMessage
        displayName.text = personalChat?.person.displayName
        userProfileImage.image = UIImage(data:personalChat?.person.userProfileImage as! Data,scale:1.0)
    }
    
    private func updateEventChatUI() {
        lastChatTime.text = eventChat?.lastContactTime
        lastMessage.text = eventChat?.lastMessage
        displayName.text = eventChat?.eventName
        userProfileImage.image = UIImage(data:eventChat?.groupImage as! Data,scale:1.0)
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
