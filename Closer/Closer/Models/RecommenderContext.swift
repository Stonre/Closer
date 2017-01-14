//
//  RecommenderContext.swift
//  Closer
//
//  Created by Kami on 2016/12/29.
//  Copyright © 2016年 Kaiming. All rights reserved.
//

import Foundation

protocol RecommenderContext {
    var requestTime: NSDate {get set}
    var source: AnyObject? {get set}
    var targetUsers: Array<User> {get set}
    var isNewRequest:Bool {get set}
    var minimumEntry: Int? {get set}
    var maximumEntry: Int? {get set}
    var initialEntryIndex: Int? {get set}
    
}
