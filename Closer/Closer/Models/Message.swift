//
//  Message.swift
//  Closer
//
//  Created by z on 2017/2/3.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import Foundation
import Firebase

class Message: NSObject {
    var from: String?
    var time: NSNumber?
    var to: String?
    var text: String?
    var type: String?
    
    func chatPartnerId() -> String? {
        return to == FIRAuth.auth()?.currentUser?.uid ? from : to
    }
}
