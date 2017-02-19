///Users/Stonre/Documents/Closer/Closer/Closer/User.swift
//  User.swift
//  Closer
//
//  Created by Lei Ding on 12/24/16.
//  Copyright © 2016 Lei Ding. All rights reserved.
//

import Foundation

enum Gender: String {
    case Male
    case Female
}

///This is the enum type of thirdparty link that a user may link his Closer account to
enum ThirdPartyLink: String {
    case Weibo
    case WeChat
    case QQ
}

struct PhoneNumber {
    var region: Int
    var number: Int
}

///Abstruction of general User interface
protocol User {
    var userName: String { get set }
    var userId: String { get set }
    var userProfileImageUrl: String? { get set }
    var backgroundImageUrl: String? { get set }
}

///Abstraction of personal user interface
protocol PersonalUser: User {
    var gender: Gender { get set }
    var age: Int { get set }
}

///Abstraction of business user interface
protocol BusinessUser: User {
    var businessName: String { get set }
    var phoneNumber: PhoneNumber? { get set }
    var credit: Int { get set }
}
