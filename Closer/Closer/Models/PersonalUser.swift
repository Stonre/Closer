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
    private var activitiesParticipatedIn: Dictionary<UInt64, Activity> = [UInt64:Activity]()
    
    /**
     - Dictionary for storing the activities a personal user released
     - Key(activityId): UInt64
     - Value(activity): GeneralActivity
     */
    private var activitiesReleased: Dictionary<UInt64, Activity> = [UInt64:Activity]()
    
    init(userName: String, userId: UInt64, gender: Gender, age: Int) {
        self.userName = userName
        self.userId = userId
        self.gender = gender
        self.age = age
    }
    
    ///function to get all the activites a user participated in or is participating in
    func getAccessibleActivitiesParticipatedIn() -> [Activity] {
        return Array(activitiesParticipatedIn.values)
    }
    
    ///function to get all the activites a user released
    func getAccessibleActivitiesReleased() -> [Activity] {
        return Array(activitiesReleased.values)
    }
    
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
    private var activitiesParticipatedIn: Dictionary<UInt64, Activity> = [UInt64:Activity]()
    
    /**
     Dictionary for storing the activities a personal user released
     - Key: activityId: UInt64
     - Value: activity: GeneralActivity
     */
    private var activitiesReleased: Dictionary<UInt64, Activity> = [UInt64:Activity]()
    
    /**
     Dictionary for storing the awards a user gets
     - Key: userId: UInt64
     - Value: user: Award
     */
    private var awards = [UInt64:Reward]()
    
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
    func changeVirtualFortune(userAction userActionType: UserActionType) {}
    
    /**
     function to set the phone number of a user
     - Parameters:
     - region: the region code of the phone number
     - number: the main part of the phone number
     */
    func setPhoneNumber(region r: Int, number n: Int) {
        phoneNumber?.region = r
        phoneNumber?.number = n
    }
    
    func addActivityParticipateIn(activity a: GeneralActivity) {
        activitiesParticipatedIn[a.identity] = a
    }
    
    func getActicityParticipateIn(activityId id: UInt64) -> Activity {
        return activitiesParticipatedIn[id]!
    }
    
    func deleteActivityParticipateIn(activityId id: UInt64) {
        activitiesParticipatedIn.removeValue(forKey: id)
        //trigger update action?
    }
    
    func addActivityReleased(activity a: GeneralActivity) {
        activitiesReleased[a.identity] = a
    }
    
    func getActivityReleased(activityId id: UInt64) -> Activity {
        return activitiesReleased[id]!
    }
    
    func deleteActivityReleased(activityId id: UInt64) {
        activitiesReleased.removeValue(forKey: id)
        //trigger update action?
    }
    
    func addFriend(user u: PersonalUserForView) {
        friends[u.userId] = u
    }
    
    func getFriend(userId id: UInt64) -> PersonalUserForView {
        return friends[id]!
    }
    
    func deleteFriend(userId id: UInt64) {
        friends.removeValue(forKey: id)
    }
    
    func addContact(user u: PersonalUserForView) {
        contacts[u.userId] = u
    }
    
    func getContact(userId id: UInt64) -> PersonalUserForView {
        return contacts[id]!
    }
    
    func deleteContact(userId id: UInt64) {
        contacts.removeValue(forKey: id)
    }
    
    func addBusinessUser(user u: BusinessUserForView) {
        savedBusinessUsers[u.userId] = u
    }
    
    func getBusinessUser(userId id: UInt64) -> BusinessUserForView {
        return savedBusinessUsers[id]!
    }
    
    func deleteBusinessUser(userId id: UInt64) {
        savedBusinessUsers.removeValue(forKey: id)
    }
    
    func addAward(award a: Reward) {}
    
    func getAward(awardId: UInt64) -> Reward {
        return awards[awardId]!
    }
    
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
