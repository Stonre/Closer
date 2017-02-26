//
//  FetchData.swift
//  Closer
//
//  Created by Lei Ding on 2/18/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

class FetchData {
    
    var firedb = FIRDatabase.database().reference()
    
    static let sharedInstance = FetchData()
    
    func fetchPersonalUserForView(userid: String, completion: @escaping (User) -> ()) {
        firedb.child("usersforview/\(userid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary {
                let user = self.generatePersonalUserForViewByDict(userDict: dict)
                completion(user)
            } else {
                print("error: fail to fetch user from firebase")
            }
            
        })
    }
    
    func fetchPersonalUserForAdmin(userid: String, completion: @escaping (User) -> ()) {
        firedb.child("usersforadmin/\(userid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary {
                let user = self.generatePersonalUserForAdminByDict(userDict: dict)
                completion(user)
            } else {
                print("error: fail to fetch user from firebase")
            }
            
        })
    }
    
    func fetchGeneralActivtiy(activityid: String, completion: @escaping (Activity) -> ()) {
        firedb.child("activities/\(activityid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary {
                let activity = self.generateGeneralActivity(activityDict: dict)
                completion(activity)
            } else {
                print("error: fail to fetch user from firebase")
            }
            
        })
    }
    
    private func generatePersonalUserForViewByDict(userDict: NSDictionary) -> User {
        let userName = userDict["name"] as? String ?? ""
        let userId = userDict["id"] as? String ?? ""
        let gender = Gender(rawValue: userDict["gender"] as? String ?? "Male")
        let age = userDict["age"] as? Int ?? 0
        let user = PersonalUserForView(userName: userName, userId: userId, gender: gender!, age: age)
        user.signature = userDict["signature"] as? String ?? ""
        user.backgroundImageUrl = userDict["background"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground.jpeg?alt=media&token=cbbf9a20-9401-4d4f-a069-7750e2d7f8b6"
        user.userProfileImageUrl = userDict["headPortrait"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait2.png?alt=media&token=fc65090f-fd7a-47f3-8a6a-bb4def659c32"
        
        return user
    }
    
    private func generatePersonalUserForAdminByDict(userDict: NSDictionary) -> User {
        let userName = userDict["name"] as? String ?? ""
        let userId = userDict["id"] as? String ?? ""
        let gender = Gender(rawValue: userDict["gender"] as? String ?? "Male")
        let age = userDict["age"] as? Int ?? 0
        let user = PersonalUserForView(userName: userName, userId: userId, gender: gender!, age: age)
        user.signature = userDict["signature"] as? String ?? ""
        user.backgroundImageUrl = userDict["background"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground.jpeg?alt=media&token=cbbf9a20-9401-4d4f-a069-7750e2d7f8b6"
        user.userProfileImageUrl = userDict["headPortrait"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait2.png?alt=media&token=fc65090f-fd7a-47f3-8a6a-bb4def659c32"
        //we should add virtual fortune, phone number and third-party links here
        
        return user
    }
    
    private func generateGeneralActivity(activityDict: NSDictionary) -> Activity {
        let activityName = activityDict["name"] as? String ?? ""
        let identity = activityDict["id"] as? String ?? ""
        let timeStart = Date(timeIntervalSince1970: Double(activityDict["timeStart"] as! String)!)
        let timeEnd = Date(timeIntervalSince1970: Double(activityDict["timeEnd"] as! String)!)
        let isOnline = activityDict["isOnline"] as? Bool ?? true
        let isActive = activityDict["isActive"] as? Bool ?? true
        let tags = (activityDict["tags"] as? String ?? "").components(separatedBy: ",")
        let numberOfParticipants = activityDict["numberOfParticipants"] as? Int ?? 0
        let authority = Authority(rawValue: activityDict["authority"] as! String)
        var descriptionUnits = [DescriptionUnit]()
        for descriptUnit in (activityDict["description"] as! NSDictionary).allValues {
            let descripUniteDict = descriptUnit as! NSDictionary
            let type = ContentType(rawValue: descripUniteDict["type"] as! String)
            let content = descripUniteDict["content"] as! String
            descriptionUnits.append(DescriptionUnit(type: type!, content: content))
        }
        var releaser = PersonalUserForView(userName: "Closer", userId: "Closer", gender: Gender.Male, age: 0)
        fetchPersonalUserForView(userid: activityDict["userReleasing"] as! String) { (user) in
            releaser = user as! PersonalUserForView
        }
        let activity = GeneralActivity(name: activityName, tags: tags, authority: authority!, description: descriptionUnits, userReleasing: releaser , identity: identity)
        activity.timeStart = timeStart
        activity.timeEnd = timeEnd
        let longitude: CLLocationDegrees
        let latitude: CLLocationDegrees
        if !isOnline {
            let location = activityDict["location"] as? NSDictionary ?? NSDictionary()
            longitude = CLLocationDegrees(location["longitude"] as! Double)
            latitude = CLLocationDegrees(location["latitude"] as! Double)
            activity.location = CLLocation(latitude: latitude, longitude: longitude)
        }
        activity.isOnline = isOnline
        activity.isActive = isActive
        activity.numberOfParticipants = numberOfParticipants
        
        return activity
    }
}
