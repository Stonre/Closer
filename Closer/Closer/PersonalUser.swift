//
//  PersonalUser.swift
//  Closer
//
//  Created by Lei Ding on 1/7/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import Foundation

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
    private var virtualFortune = VirtualFortune()
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
     function to change the virtual fortune a user has
     - Parameters:
        - userAction: a user's action that causes his virtual fortune to change
     */
    func changeVirtualFortune(userAction: UserActionType) {}
    
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
