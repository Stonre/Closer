//
//  Searcher.swift
//  Closer
//
//  Created by Lei Ding on 1/1/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import Foundation

class Searcher {
    /**
     function to search for activities by keywords through querying remote server
     
     - Parameters:
        - keyword: the keyword users input in the search bar
     - Returns: a list of activities related to the keyword
    */
    static func remoteActivitySearchByKeywords(keyword: String) -> [GeneralActivity] {}
    
    /**
     function to search for messages that match keywords through querying local core data
     
     - Parameters:
        - keyword: the keyword users input in the search bar
     - Returns: a list of messages that contains the keyword
    */
    static func localChatSearchByKeywords(keyword: String) -> [Message] {}
}
