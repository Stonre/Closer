//
//  PersonalChatProfile.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import Foundation

class PersonalChatProfile {
    
    let userId: String?
    let userName: String
    var userNickname: String?
    var displayName: String?
    var userProfileImage: String?
    
    init(userId: String, userNickname: String?, userDict: NSDictionary) {
        self.userId = userId
        self.userName = userDict["name"] as! String
        self.userNickname = userNickname
        self.displayName = userNickname ?? userName
        self.userProfileImage = userDict["profileImageUrl"] as? String
    }
    
    init(userId: String,
         userName: String,
         userNickname: String?,
         userProfileImage: String?
        ){
        self.userId = userId
        self.userName = userName
        self.userNickname = userNickname
        self.displayName = userNickname ?? userName
        self.userProfileImage = userProfileImage
    }
 
}
