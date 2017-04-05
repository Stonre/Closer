//
//  GeneralActivity.swift
//  Closer
//
//  Created by Lei Ding on 1/7/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase


///Class for a general activity based on Activity protocol
class GeneralActivity: Activity {
    var name: String
    var identity: String
    var timeStart: Date?
    var timeEnd: Date?
    var location: CLLocation?
    var isOnline: Bool = true
    var isActive: Bool = true
    var tags: [String] = []
    var numberOfParticipants: Int = 0
    var authority: Authority
    var description: [DescriptionUnit]
    var participantIDs = [String]()
    var participants = [String: User]()
    ///the user that releases the activity
    var userReleasing: User
    ///a list of users that are assigned by the user releasing this activity to take part in it
    var assignedParticipants = [String]()
    var categories = [String]()
    
    init(activityDict: NSDictionary) {
        self.name = activityDict["name"] as? String ?? ""
        self.identity = activityDict["id"] as? String ?? ""
        if let ts = activityDict["timeStartStamp"] {
            self.timeStart = Date(timeIntervalSince1970: Double(ts as! NSDecimalNumber))
        }
        if let te = activityDict["timeEndStamp"] {
            self.timeEnd = Date(timeIntervalSince1970: Double(te as! NSDecimalNumber))
        }
        self.isOnline = activityDict["isOnline"] as? Bool ?? true
        self.isActive = activityDict["isActive"] as? Bool ?? true
        self.tags = (activityDict["tags"] as? String ?? "").components(separatedBy: ",")
        self.categories = (activityDict["categories"] as? String ?? "others").components(separatedBy: ",")
        self.numberOfParticipants = activityDict["numberOfParticipants"] as? Int ?? 0
        self.authority = Authority(rawValue: activityDict["authorization"] as! String)!
        var descriptionUnits = [DescriptionUnit]()
        if let ad = activityDict["description"] {
            for descriptUnit in (ad as! NSArray) {
                let descripUniteDict = descriptUnit as! NSDictionary
                let type = ContentType(rawValue: descripUniteDict["type"] as! String)
                let content = descripUniteDict["content"] as! String
                descriptionUnits.append(DescriptionUnit(type: type!.rawValue, content: content))
            }
        }
        self.description = descriptionUnits
        self.userReleasing = PersonalUserForView(userName: "Closer", userId: activityDict["releasingUserID"] as! String, gender: Gender.Male, age: 0)
        let longitude: CLLocationDegrees
        let latitude: CLLocationDegrees
        if !isOnline {
            let location = activityDict["location"] as? NSDictionary ?? NSDictionary()
            longitude = CLLocationDegrees(location["longitude"] as! Double)
            latitude = CLLocationDegrees(location["latitude"] as! Double)
            self.location = CLLocation(latitude: latitude, longitude: longitude)
        }
    }
    
    init(name: String, tags: [String], authority: Authority, description: [DescriptionUnit], userReleasing: PersonalUserForView, identity: String) {
        self.name = name
        self.tags = tags
        self.authority = authority
        self.description = description
        self.userReleasing = userReleasing
        self.identity = identity
    }
    
    ///function to make assigned participant as participant when the assigned participant agrees to take part in this activity
    func addAssignedParticipant(user: User) {}
    
    func addParticipant(user: User) {}
    
    func deleteParticipant(userId: String) {}
    
    func getParticipant(userId id: String) -> User {
        return participants[id]!
    }
}
