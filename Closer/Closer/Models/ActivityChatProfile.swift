//
//  eventChat.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import Foundation

class ActivityChatProfile {
    var participants = [String: [String: String]]()
    var groupImage: String?
    var activityName: String
    var activityId: String?
    var userReleasing: String?
    
    init(activityId: String,
         activityName: String,
         participants: [String: [String: String]],
         groupImage: String,
         userReleasing: String
        ){
        self.activityId = activityId
        self.activityName = activityName
        self.participants = participants
        self.groupImage = groupImage
        self.userReleasing = userReleasing
    }

    
}
