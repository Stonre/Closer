//
//  Activity.swift
//  Closer
//
//  Created by Lei Ding on 12/25/16.
//  Copyright © 2016 Lei Ding. All rights reserved.
//

import Foundation
import CoreLocation

/**
    enum type to define the authority of an activity
*/
enum Authority {
    case FriendsAndContacts
    case OnlyFriends
    case OnlyContacts
    case OnlyAssignedFriendsOrContacts
    case Public
}

/**
    struct to define the description of an activity, which contains the form of music, image, hyperlink and text
 */
struct Description {
    var musics: [NSData]?
    var images: [NSData]?
    var links: [String]?
    var text: String!
}

/**
    abstraction of Activity
 */
protocol Activity {
    var name: String { get set }
    var timeStart: Date? { get set }
    var timeEnd: Date? { get set }
    var location: CLLocation? { get set }
    var tags: [String] { get set }
    var numberOfParticipants: Int { get set }
    var authority: Authority { get set }
    var description: Description { get set }
    var participants: [UInt64:User] { get set }
}

/**
    Class for a general activity based on Activity protocol
 */
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
    var assignedParticipants: [UInt64:User] = [:]
    
    init(name: String, tags: [String], authority: Authority, description: Description, userReleasing: User) {
        self.name = name
        self.tags = tags
        self.authority = authority
        self.description = description
        self.userReleasing = userReleasing
    }
    
    /**
        function to make assigned participant as participant when the assigned participant agrees to take part in this activity
     */
    func addAssignedParticipant(user: User) {}
    func addParticipant(user: User) {}
    func deleteParticipant(userId: UInt64) {}
    func getParticipant(userId: UInt64) -> User {}
}
