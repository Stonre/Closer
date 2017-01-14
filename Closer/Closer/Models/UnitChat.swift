//
//  ChatListUnit.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import Foundation

protocol UnitChat {
    var chatId: String? {get set}
    var lastMessage: String? { get set }
    var lastContactTime: String? { get set }
    
}
