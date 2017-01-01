//
//  Searcher.swift
//  Closer
//
//  Created by Lei Ding on 1/1/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import Foundation

class Searcher {
    /// function to search for activities by keywords through querying remote server
    static func remoteActivitySearchByKeywords(keyword: String) -> [GeneralActivity] {}
    /// function to search for messages that match keywords through querying local core data
    static func localChatSearchByKeywords(keyword: String) -> [Message] {}
}
