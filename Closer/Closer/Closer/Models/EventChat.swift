//
//  eventChat.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import Foundation

class EventChat: UnitChat {
    var participants = [PersonalChatProfile]()
    var groupImage: NSData
    var eventName: String

    var chatId: String?
    var lastMessage: String?
    var lastContactTime: String?
    
    init(participants: [PersonalChatProfile],
         eventName: String,
         groupImage: NSData,
         lastMessage: String?,
         lastContactTime: String?
        ){
        self.participants = participants
        self.eventName = eventName
        self.groupImage = groupImage
        self.lastMessage = lastMessage
        self.lastContactTime = lastContactTime
    }

    
}
