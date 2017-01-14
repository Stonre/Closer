//
//  ActivityPreviewTableViewCell.swift
//  Closer
//
//  Created by Lei Ding on 1/12/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit

class ActivityPreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userHeaderPortrait: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var activityName: UILabel!
    
    @IBOutlet weak var activityContent: UILabel!
    
    var activity: ActivitySample? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let activity = self.activity {
            userHeaderPortrait?.image = activity.releaser?.headPortrait
            userName?.text = activity.releaser?.userName
            activityName?.text = activity.activityName
            activityContent?.text = activity.activityContent
        }
    }

}
