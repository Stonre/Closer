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

enum ThirdPartyLink {
    case Weibo
    case WeChat
    case QQ
}

struct PhoneNumber {
    var region: Int
    var number: Int
}

protocol User {
    var userName: String { get set }
    var userId: UInt64 { get set }
    var headPortrait: NSData? { get set }
    var background: NSData? { get set }
}

protocol PersonalUser: User {
    var gender: Gender { get set }
    var age: Int { get set }
}

protocol BusinessUser: User {
    var businessName: String { get set }
    var phoneNumber: PhoneNumber? { get set }
    var credit: Int { get set }
}

class PersonalUserForView: PersonalUser {
    var userName: String
    var userId: UInt64
    var headPortrait: NSData?
    var background: NSData?
    var gender: Gender
    var age: Int
    private var activitiesParticipatedIn: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    private var activitiesReleased: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    
    init(userName: String, userId: UInt64, gender: Gender, age: Int) {
        self.userName = userName
        self.userId = userId
        self.gender = gender
        self.age = age
    }
    
    func getAccessibleActivitiesParticipatedIn() -> [GeneralActivity] {}
    func getAccessibleActivitiesReleased() -> [GeneralActivity] {}
    
}

class PersonalUserAdmin: PersonalUser {
    var userName: String
    var userId: UInt64
    var headPortrait: NSData?
    var background: NSData?
    var gender: Gender
    var age: Int
    private var virtualMoney = 0
    private var phoneNumber: PhoneNumber?
    private var ThirdPartyLinks: [ThirdPartyLink]?
    private var friends: Dictionary<UInt64, PersonalUserForView> = [UInt64:PersonalUserForView]()
    private var degreeOfFriendship: Dictionary<UInt64, Int> = [UInt64:Int]()
    private var contacts: Dictionary<UInt64, PersonalUserForView> = [UInt64:PersonalUserForView]()
    private var degreeOfContactship: Dictionary<UInt64, Int> = [UInt64:Int]()
    private var savedBusinessUsers: Dictionary<UInt64, BusinessUserForView> = [UInt64:BusinessUserForView]()
    private var evaluationOfSavedBusinessUsers: Dictionary<UInt64, Int> = [UInt64:Int]()
    private var activitiesParticipatedIn: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    private var activitiesReleased: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    private var awards: Dictionary<UInt64, Award> = [UInt64:Award]()
    
    init(userName: String, userId: UInt64, gender: Gender, age: Int) {
        self.userName = userName
        self.userId = userId
        self.gender = gender
        self.age = age
    }
    
    func increaseVirtualMoneyBy(money: Int) {}
    func decreaseVirtualMoneyBy(money: Int) {}
    func setPhoneNumber(region: Int, number: Int) {}
    func addActivityParticipateIn(activity: GeneralActivity) {}
    func getActicityParticipateIn(activityId: UInt64) -> GeneralActivity {}
    func deleteActivityParticipateIn(activityId: UInt64) {}
    func addActivityReleased(activity: GeneralActivity) {}
    func getActivityReleased(activityId: UInt64) -> GeneralActivity {}
    func deleteActivityReleased(activityId: UInt64) {}
    func addFriend(user: PersonalUserForView) {}
    func getFriend(userId: UInt64) -> PersonalUserForView {}
    func deleteFriend(userId: UInt64) {}
    func addContact(user: PersonalUserForView) {}
    func getContact(userId: UInt64) -> PersonalUserForView {}
    func deleteContact(userId: UInt64) {}
    func addBusinessUser(user: BusinessUserForView) {}
    func getBusinessUser(userId: UInt64) -> BusinessUserForView {}
    func deleteBusinessUser(userId: UInt64) {}
    func addAward(award: Award) {}
    func getAward(awardId: UInt64) -> Award {}
    func deleteAward(awardId: UInt64) {}
    func updateDegreeOfFriendship(userId: UInt64, evaluation: Int) {}
    func updateDegreeOfContactship(userId: UInt64, evaluation: Int) {}
    func updateEvaluationOfSavedBusinessUser(userId: UInt64, evaluation: Int) {}
}

struct BusinessUserForView: BusinessUser {
    var userName: String
    var userId: UInt64
    var headPortrait: NSData?
    var background: NSData?
    var businessName: String
    var phoneNumber: PhoneNumber?
    var credit: Int = 0
    private var activitiesReleased: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    
    init(businessName: String, userName: String, userId: UInt64) {
        self.userName = userName
        self.userId = userId
        self.businessName = businessName
    }
    
    func getActivityReleased(activityId: UInt64) -> GeneralActivity {}
}
