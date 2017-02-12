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
enum Authority: String {
    case FriendsAndContacts
    case OnlyFriends
    case OnlyContacts
    case OnlyAssignedFriendsOrContacts
    case Public
}

///Content type for description
enum ContentType: String {
    case Image
    case Text
    case Voice
    case Video
    case Hyperlink
}

///struct to define the description unit of an activity, which contains two members: type and content. Type is a data type of ContentType defined above in this file and content is String type. When it's used, user might first need to check the type of a description unit and then based on the type, use the content.
struct DescriptionUnit {
    var type: ContentType
    var content: String
}

///Abstraction of Activity
protocol Activity {
    var name: String { get set }
    var identity: String { get set }
    var timeStart: Date? { get set }
    var timeEnd: Date? { get set }
    var location: CLLocation? { get set }
    var tags: [String] { get set }
    var numberOfParticipants: Int { get set }
    var authority: Authority { get set }
    var description: [DescriptionUnit] { get set }///This is a array of description unit. If a user tries to get a complete good looking description, he may need to check all the elements of this array and combine all the units together based on their types.
    var participants: [String:User] { get set }
}
