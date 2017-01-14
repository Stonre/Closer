//
//  OtherUserTableViewCell.swift
//  Closer
//
//  Created by Lei Ding on 1/12/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit

class OtherUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userHeaderPortrait: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    var user: UserSample? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        userHeaderPortrait?.image = nil
        userName?.text = nil
        if let user = self.user {
            userHeaderPortrait?.image = user.headPortrait
            userName?.text = user.userName
        }
    }

}
