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
 - FriendsAndContacts: only friends and contacts can see the activity
 - OnlyFriends: only friends can see the activity
 - OnlyContacts: only contacts can see the activity
 - OnlyAssignedFriendsOrContacts: only those friends or contacts that are assigned to finish the activity can see the activity
 - Public: everyone can see the activity
*/
enum Authority {
    case FriendsAndContacts
    case OnlyFriends
    case OnlyContacts
    case OnlyAssignedFriendsOrContacts
    case Public
}

///struct to define the description of an activity, which contains the form of music, image, hyperlink and text
struct Description {
    var musics: [NSData]?
    var images: [NSData]?
    var links: [String]?
    var text: String!
    
    init(txt: String) {
        self.text = txt
    }
}

///Abstraction of Activity
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
