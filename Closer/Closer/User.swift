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
enum ThirdPartyLink {
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
    var userId: UInt64 { get set }
    var headPortrait: NSData? { get set }
    var background: NSData? { get set }
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

///View-only Class for personal user.
///This class is mainly used for storing the non-private information of a personal user
class PersonalUserForView: PersonalUser {
    var userName: String
    var userId: UInt64
    var headPortrait: NSData?
    var background: NSData?
    var gender: Gender
    var age: Int
    
    /**
     Dictionary for storing the activities a personal user attended or is attending
     - Key(activityId): UInt64
     - Value(activity): GeneralActivity
     */
    private var activitiesParticipatedIn: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    
    /**
     - Dictionary for storing the activities a personal user released
     - Key(activityId): UInt64
     - Value(activity): GeneralActivity
     */
    private var activitiesReleased: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    
    init(userName: String, userId: UInt64, gender: Gender, age: Int) {
        self.userName = userName
        self.userId = userId
        self.gender = gender
        self.age = age
    }
    
    ///function to get all the activites a user participated in or is participating in
    func getAccessibleActivitiesParticipatedIn() -> [GeneralActivity] {}
    
    ///function to get all the activites a user released
    func getAccessibleActivitiesReleased() -> [GeneralActivity] {}
    
}

///Administration Class for personal user.
///This class contains all the information of a personal user including private information and non-private information
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
    
    /**
     Dictionary for storing the friends of a user
     - Key(userId): UInt64
     - Value(user): PersonalUserForView
     */
    private var friends: Dictionary<UInt64, PersonalUserForView> = [UInt64:PersonalUserForView]()
    
    /**
     Dictionary for storing the degrees of friendship for each friend
     - Key(userId): UInt64
     - Value(user): Int
     */
    private var degreeOfFriendship: Dictionary<UInt64, Int> = [UInt64:Int]()
    
    /**
     Dictionary for storing the contacts of a user
     - Key(userId): UInt64
     - Value(user): PersonalUserForView
     */
    private var contacts: Dictionary<UInt64, PersonalUserForView> = [UInt64:PersonalUserForView]()
    
    /**
     Dictionary for storing the degrees of contactship of for each contact
     - Key(userId): UInt64
     - Value(user): Int
     */
    private var degreeOfContactship: Dictionary<UInt64, Int> = [UInt64:Int]()
    
    /**
     Dictionary for storing the saved business user of a user
     - Key(userId): UInt64
     - Value(user): BusinessUserForView
     */
    private var savedBusinessUsers: Dictionary<UInt64, BusinessUserForView> = [UInt64:BusinessUserForView]()
    
    /**
     Dictionary for storing the evaluations for each business user a user saved
     - Key(userId): UInt64
     - Value(user): Int
     */
    private var evaluationOfSavedBusinessUsers: Dictionary<UInt64, Int> = [UInt64:Int]()
    
    /**
     Dictionary for storing the activities a personal user attended or is attending
     - Key: activityId: UInt64
     - Value: activity: GeneralActivity
     */
    private var activitiesParticipatedIn: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    
    /**
     Dictionary for storing the activities a personal user released
     - Key: activityId: UInt64
     - Value: activity: GeneralActivity
     */
    private var activitiesReleased: Dictionary<UInt64, GeneralActivity> = [UInt64:GeneralActivity]()
    
    /**
     Dictionary for storing the awards a user gets
     - Key: userId: UInt64
     - Value: user: Award
     */
    private var awards: Dictionary<UInt64, Award> = [UInt64:Award]()
    
    init(userName: String, userId: UInt64, gender: Gender, age: Int) {
        self.userName = userName
        self.userId = userId
        self.gender = gender
        self.age = age
    }
    
    /**
     function to change the virtual money a user has
     - Parameters:
        - money: Int amount of money that makes changes to total virtual money
     */
    func changeVirtualMoneyBy(money: Int) {}
    
    /**
     function to set the phone number of a user
     - Parameters:
        - region: the region code of the phone number
        - number: the main part of the phone number
     */
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
    
    /**
     function to update the degree of friendship based on friend user id and the evaluation of him
     - Parameters:
        - userId: UInt64
        - evaluation: Int
     */
    func updateDegreeOfFriendship(userId: UInt64, evaluation: Int) {}
    
    /**
     function to update the degree of contactship based on contact user id and the evaluation of him
     - Parameter:
        - userId: UInt64
        - evaluation: Int
     */
    func updateDegreeOfContactship(userId: UInt64, evaluation: Int) {}
    
    /**
     function to update the evaluation of a saved business user    
     - Parameters:
        - userId: UInt64
        - evaluation: Int
     */
    func updateEvaluationOfSavedBusinessUser(userId: UInt64, evaluation: Int) {}
}

///View-only Class for business user.
///This class is mainly used for storing the non-private information of a business user
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
    
    /**
     function to get the activity this business user released based on the activity id
     - Parameters:
        - activityId: UInt64
     - Returns: a activity released by the business user
     */
    func getActivityReleased(activityId: UInt64) -> GeneralActivity {}
}
