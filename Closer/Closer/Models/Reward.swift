//
//  Reward.swift
//  Closer
//
//  Created by Kami on 2016/12/29.
//  Copyright © 2016年 Kaiming. All rights reserved.
//

import Foundation

enum RewardSource {
    case Achievement
    case Business //Sale
    
    case Others
}

enum RewardValue {
    case Expensive
    case Common
    case Cheap
    
    case Others
}

enum RewardType {
    case Emoji
    case Coupon
    
    case Others
}

protocol Reward {
    var Identifier: String {get}
    var name: String {get set}
    var source: RewardSource {get set}
    var type: RewardType {get set}
    var quantity: Int {get set}
    var birthday: NSDate {get set} //obtainedDate
    var validDate: NSDate {get set}
    var expiredDate: NSDate? {get set}
    var canBeShared: Bool {get set}
    var owners: Array<User> {get set}
    var value: RewardValue {get set}
}
