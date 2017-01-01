//
//  ChatUnit.swift
//  Closer
//
//  Created by z on 2016/12/31.
//  Copyright © 2016年 Closer. All rights reserved.
//

import Foundation

/**
 Message type.
 
 - Text: For text strings.
 - Voice: For voice messages.
 - Image: For images.
 - Hyperlink: For hyperlinks that connected to website.
 - Facialexpression: For facial expressions.
*/
enum MessageType {
    case Text
    case Voice
    case Image
    case Hyperlink
    case FacialExpression
}

///A message of type MessageType
struct Message {
    
    ///Whether the message has been read or not
    var isRead: Bool
    
    ///The type of the message
    var messageType: MessageType
}

///Abstraction for general chat
protocol Chat {
    var hostUser: PersonalUserAdmin { get set }
    var chatParticipants: Dictionary<UInt64, PersonalUserForView> { get set }
    
    /**
     Send a message to the chat
     
     - Parameters:
        - message: the message to be sent
     */
    func sendMessage(message: Message)
    
    /**
     Receive messages
     
     - Returns: a list of messages received
     */
    func receiveMessage() -> [Message]
    
    ///Read all unread messages
    func readMessage()
    
    ///Load message history from disk to memory
    func loadMessage()
}


///Class for general chatunits
class ChatUnit: Chat {
    ///All messages in memory
    var messageLoaded: [(userId: UInt64, message: Message)] = []
    
    ///The personal information of yourself
    var hostUser: PersonalUserAdmin
    
    ///the information of all participants other than yourself, stored in dictionary
    var chatParticipants: Dictionary<UInt64, PersonalUserForView>
    
    /**
     Initialize a chat unit with all people included in the chat
     
     - Parameters:
        - hostUser: the personal information of yourself
        - chatParticipants: the information of all participants other than yourself, stored in dictionary
    */
    init(hostUser: PersonalUserAdmin,
         chatParticipants: Dictionary<UInt64, PersonalUserForView>) {
        self.hostUser = hostUser
        self.chatParticipants = chatParticipants
    }
    func sendMessage(message: Message) { }
    func receiveMessage() -> [Message] { }
    func readMessage() { }
    func loadMessage() { }
}

///Personal chat unit which includes only you and your friend
class PersonalChatUnit: ChatUnit {
    // TODO: difference with chatunit
}

///Chat unit according to activities, includes all activity participants
class ActivityChatUnit: ChatUnit {
    
    ///The activity which the chat is based on
    var activity: GeneralActivity
    
    /**
     Initialize a chat for an activity with all people included in the chat
     
     - Parameters:
        - hostUser: the personal information of yourself
        - chatParticipants: the information of all participants other than yourself, stored in dictionary
        - activity: the activity which the chat is based on
     */
    init(hostUser: PersonalUserAdmin,
         chatParticipants: Dictionary<UInt64, PersonalUserForView>,
         activity: GeneralActivity) {
        super.init(hostUser: hostUser, chatParticipants: chatParticipants)
        self.activity = activity
    }
    
    /**
     Add the people into the chat unit who is a new participant of that activity
     
     - Parameters:
        - user: the information of the new participant
    */
    func addChatParticipant(user: PersonalUserForView) { }
    
    /**
     Delete the people from the chat unit who no longer is a participant of that activity
     
     - Parameters:
        - userId: the unique identification of that user
     */
    func deleteChatParticipant(userId: UInt64) { }
}










