//
//  BusinessUser.swift
//  Closer
//
//  Created by Lei Ding on 1/7/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//
import Foundation


///View-only Class for business user.
///This class is mainly used for storing the non-private information of a business user
struct BusinessUserForView: BusinessUser {
    var userName: String
    var userId: UInt64
    var headPortrait: NSData?
    var background: NSData?
    var businessName: String
    var phoneNumber: PhoneNumber?
    var credit: Int = 0
    private var activitiesReleased: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    
    init(businessName: String, userName: String, userId: UInt64) {
        self.userName = userName
        self.userId = userId
        self.businessName = businessName
    }
    
    /**
     function to get the activity this business user released based on the activity id
     - Parameters:
     - activityId: UInt64
     - Returns: an activity released by the business user
     */
    func getActivityReleased(activityId: UInt64) -> GeneralActivity {
        return activitiesReleased[activityId]!
    }
}
