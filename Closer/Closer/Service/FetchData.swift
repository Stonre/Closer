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
    
    static let defaultProfileImageURL = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait2.png?alt=media&token=fc65090f-fd7a-47f3-8a6a-bb4def659c32"
    
    static let defaultBackgroundImageURL = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground.jpeg?alt=media&token=cbbf9a20-9401-4d4f-a069-7750e2d7f8b6"
    
    func fetchPersonalUserForView(userid: String, completion: @escaping (User) -> ()) {
        firedb.child("users/\(userid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary {
                let user = PersonalUserForView(userDict: dict)
                completion(user)
            } else {
                print("error: fail to fetch user from firebase")
            }
            
        })
    }
    
    func fetchPersonalUserForAdmin(userid: String, completion: @escaping (User) -> ()){
        firedb.child("usersforadmin/\(userid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary {
                let user = PersonalUserAdmin(userDict: dict)
                completion(user)
            } else {
                print("error: fail to fetch user from firebase")
            }
            
        })
    }
    
    func fetchGeneralActivtiy(activityid: String, completion: @escaping (Activity) -> ()) {
        firedb.child("activities/\(activityid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary {
                let activity = GeneralActivity(activityDict: dict)
                self.fetchPersonalUserForView(userid: activity.userReleasing.userId) { (user) in
                    let userId = activity.userReleasing.userId
                    activity.identity = activityid
                    activity.userReleasing = user
                    activity.userReleasing.userId = userId
                    completion(activity)
                }
            } else {
                print("error: fail to fetch user from firebase")
            }
            
        })
    }
}
