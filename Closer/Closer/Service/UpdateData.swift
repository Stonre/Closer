//
//  UpdateData.swift
//  Closer
//
//  Created by Lei Ding on 4/4/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import Foundation
import Firebase

class UpdateData {
    
    var firedb = FIRDatabase.database().reference()
    
    static let sharedInstance = UpdateData()
    
    func addParticipant(participantId pid: String, activity a: Activity) {
        let user = FIRAuth.auth()?.currentUser
        let participant = ["identity": pid,
                           "name": user?.displayName,
                           "profileImageUrl": user?.photoURL?.absoluteString]
        let activity = ["name": a.name]
        let updates = ["activities/\(a.identity)/participants/\(pid)": participant,
                      "users/\(pid)/participated-activity/\(a.identity)": activity,
                      "users/\(pid)/active-activities/\(a.identity)": activity]
        firedb.updateChildValues(updates)
    }
}
