//
//  eventChat.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import Foundation

class ActivityChatProfile {
    var participants = [String?]()
    var groupImage: String?
    var activityName: String
    var activityId: String?
    var userReleasing: PersonalUserForView
    
    init(activityId: String,
         activityName: String,
         participants: [String?],
         groupImage: String,
         userReleasing: PersonalUserForView
        ){
        self.activityId = activityId
        self.activityName = activityName
        self.participants = participants
        self.groupImage = groupImage
        self.userReleasing = userReleasing
    }

    
}
