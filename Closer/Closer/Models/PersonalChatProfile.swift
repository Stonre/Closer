//
//  PersonalChatProfile.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import Foundation

class PersonalChatProfile {
    let userId: String
    let userName: String
    var userNickname: String?
    var displayName: String
    let userProfileImage: NSData
    
    init(userId: String,
         userName: String,
         userNickname: String?,
         userProfileImage: NSData
        ){
        self.userId = userId
        self.userName = userName
        self.userNickname = userNickname
        self.displayName = userNickname ?? userName
        self.userProfileImage = userProfileImage
    }
}
