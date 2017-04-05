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
    
    func addParticipant(participantId pid: String, activityId aid: String) {
        let participant = ["identity": pid]
        let activity = [aid: aid]
        let updates = ["activities/\(aid)/participants/\(pid)": participant,
                      "users/\(pid)/participated-activity": activity,
                      "users/\(pid)/active-activities": activity]
        firedb.updateChildValues(updates)
    }
}
