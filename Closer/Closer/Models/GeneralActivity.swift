//
//  GeneralActivity.swift
//  Closer
//
//  Created by Lei Ding on 1/7/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//
import Foundation
import CoreLocation


///Class for a general activity based on Activity protocol
class GeneralActivity: Activity {
    var name: String
    var timeStart: Date?
    var timeEnd: Date?
    var location: CLLocation?
    var tags: [String] = []
    var numberOfParticipants: Int = 0
    var authority: Authority
    var description: Description
    var participants: [UInt64:User] = [:]
    ///the user that releases the activity
    var userReleasing: User
    ///a list of users that are assigned by the user releasing this activity to take part in it
    var assignedParticipants: [UInt64:PersonalUserForView] = [:]
    
    init(name: String, tags: [String], authority: Authority, description: Description, userReleasing: PersonalUserForView) {
        self.name = name
        self.tags = tags
        self.authority = authority
        self.description = description
        self.userReleasing = userReleasing
    }
    
    ///function to make assigned participant as participant when the assigned participant agrees to take part in this activity
    func addAssignedParticipant(user: PersonalUserForView) {}
    
    func addParticipant(user: PersonalUserForView) {}
    
    func deleteParticipant(userId: UInt64) {}
    
    func getParticipant(userId: UInt64) -> PersonalUserForView {
        return participants[userId]! as! PersonalUserForView
    }
}
