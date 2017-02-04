////
////  OtherHomePageTableViewCell.swift
////  Closer
////
////  Created by Lei Ding on 1/14/17.
////  Copyright © 2017 Lei Ding. All rights reserved.
////
//
//import UIKit
//
//class OtherHomePageTableViewCell: UITableViewCell {
//    
//    @IBOutlet weak var userHeadPortrait: UIImageView!
//    
//    @IBOutlet weak var userName: UILabel!
//    
//    @IBOutlet weak var activityName: UILabel!
//    
//    @IBOutlet weak var activityContent: UILabel!
//    
//    var activity: ActivitySample? {
//        didSet {
//            updateUI()
//        }
//    }
//    
//    func updateUI() {
//        userHeadPortrait?.image = nil
//        userName?.text = nil
//        activityName?.text = nil
//        activityContent?.text = nil
//        
//        if let activity = self.activity {
//            userHeadPortrait?.image = activity.releaser?.headPortrait
//            userName?.text = activity.releaser?.userName
//            activityName?.text = activity.activityName
//            activityContent?.text = activity.activityContent
//        }
//    }
//    
//}
