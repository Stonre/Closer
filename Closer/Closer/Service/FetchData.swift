//
//  FetchData.swift
//  Closer
//
//  Created by Lei Ding on 2/18/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import Foundation
import Firebase

class FetchData {
    
//    var firedb = FIRDatabase.database().reference()
//    
//    static let sharedInstance = FetchData()
//    
//    func fetchUser(userid id: String, completion: @escaping (User) -> ()) {
//        firedb.child("users/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dict = snapshot.value as? NSDictionary {
//                let user = self.generatePersonalUserForViewByDict(userDict: dict)
//                completion(user)
//            } else {
//                print("error: fail to fetch user from firebase")
//            }
//            
//        })
//    }
//    
//    func fetchActivtiy(activityid id: String, completion: @escaping (NSDictionary) -> ()) {
//        firedb.child("activities/\(id)").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dict = snapshot.value as? NSDictionary {
//                completion(dict)
//            } else {
//                print("error: fail to fetch user from firebase")
//            }
//            
//        })
//    }
//    
//    private func generatePersonalUserForViewByDict(userDict: NSDictionary) -> User {
//        let userName = userDict["name"] as? String ?? ""
//        let userId = userDict["id"] as? String ?? ""
//        let gender = Gender(rawValue: userDict["gender"] as! String)
//        let age = userDict["age"] as? Int ?? 0
//        let signature = userDict["signature"] as? String ?? ""
//        let backgroundImageURL = URL(string: (userDict["background"] as? String)!)
//        return PersonalUserForView()
//    }
}
