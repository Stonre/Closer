//
//  Activity.swift
//  Closer
//
//  Created by Lei Ding on 12/25/16.
//  Copyright © 2016 Lei Ding. All rights reserved.
//

import Foundation
import CoreLocation

enum Authority {
    case FriendsAndContacts
    case OnlyFriends
    case OnlyContacts
    case OnlyAssignedFriendsOrContacts
    case Public
}

struct Description {
    var musics: [NSData]?
    var images: [NSData]?
    var links: [String]?
    var text: String!
}

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
    var userReleasing: User
    var assignedParticipants: [UInt64:User] = [:]
    
    init(name: String, tags: [String], authority: Authority, description: Description, userReleasing: User) {
        self.name = name
        self.tags = tags
        self.authority = authority
        self.description = description
        self.userReleasing = userReleasing
    }
    
    func addAssignedParticipant(user: User) {}
    func addParticipant(user: User) {}
    func deleteParticipant(userId: UInt64) {}
    func getParticipant(userId: UInt64) -> User {}
}
