//
//  personalChat.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import Foundation

class PersonalChat: UnitChat {
    var person: PersonalChatProfile
    
    var chatId: String?
    var lastMessage: String?
    var lastContactTime: String?
    
    init(person: PersonalChatProfile,
         lastMessage: String?,
         lastContactTime: String?
        ){
        self.person = person
        self.lastMessage = lastMessage
        self.lastContactTime = lastContactTime
    }
    
}
