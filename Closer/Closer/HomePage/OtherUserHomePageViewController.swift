////
////  OtherUserHomePageViewController.swift
////  Closer
////
////  Created by Lei Ding on 1/14/17.
////  Copyright © 2017 Lei Ding. All rights reserved.
////
//
//import UIKit
//
//class OtherUserHomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    @IBOutlet weak var background: UIImageView!
//    
//    @IBOutlet weak var nickName: UILabel!
//    
//    @IBOutlet weak var homeWords: UILabel!
//    
//    @IBAction func moreButton(_ sender: UIButton) {
//    }
//    
//    @IBAction func activityReleaseButton(_ sender: UIButton) {
//        selectState = 0
//    }
//    
//    @IBAction func activityParticipatedInButton(_ sender: UIButton) {
//        selectState = 1
//    }
//    
//    @IBOutlet weak var activityTable: UITableView!
//    
//    var selectState = 0 {
//        didSet {
//            activityTable.reloadData()
//        }
//    }
//    
//    var activitiesParticipatedIn = [ActivitySample]()
//    var activitiesRelease = [ActivitySample]()
//    var contacts = [UserSample]()
//    var friends = [UserSample]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initSampleData()
//        activityTable.delegate = self
//        activityTable.dataSource = self
//        activityTable.estimatedRowHeight = 90
//        activityTable.rowHeight = UITableViewAutomaticDimension
//        // Do any additional setup after loading the view.
//    }
//    
//    private func initSampleData() {
//        //for sample users
//        let contactsName: [String] = ["Yi Zhou", "Yi Ding", "Peter"]
//        let friendsName: [String] = ["Zenith", "Zack", "Kami"]
//        let contactsHeader: [String] = ["sampleHeaderPortrait1", "sampleHeaderPortrait2", "sampleHeaderPortrait3"]
//        let friendsHeaer: [String] = ["sampleHeaderPortrait4", "sampleHeaderPortrait5", "sampleHeaderPortrait6"]
//        var user = UserSample()
//        for i in 0...2 {
//            user.userName = contactsName[i]
//            user.headPortrait = UIImage(named: contactsHeader[i])
//            contacts.append(user)
//            user.userName = friendsName[i]
//            user.headPortrait = UIImage(named: friendsHeaer[i])
//            friends.append(user)
//        }
//        
//        //for sample activities
//        let activityPName: [String] = ["activity 1", "activity 2", "activity 3"]
//        let activityRName: [String] = ["activity 1", "activity 2", "activity 3"]
//        let activityPContent: [String] = ["This is activity 1's content", "This is activity 2's content", "This is activity 3's content"]
//        let activityRContent: [String] = ["This is activity 1's content", "This is activity 2's content", "This is activity 3's content"]
//        var activity = ActivitySample()
//        for i in 0...2 {
//            activity.activityName = activityPName[i]
//            activity.activityContent = activityPContent[i]
//            activity.releaser = friends[i]
//            activitiesParticipatedIn.append(activity)
//            activity.activityName = activityRName[i]
//            activity.activityContent = activityRContent[i]
//            activity.releaser = contacts[i]
//            activitiesRelease.append(activity)
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch selectState {
//        case 0:
//            return activitiesRelease.count
//        case 1:
//            return activitiesParticipatedIn.count
//        default:
//            return activitiesRelease.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell?
//        switch selectState {
//        case 0:
//            cell = activityTable.dequeueReusableCell(withIdentifier: "OtherUserActivities", for: indexPath)
//            let activityPreview = activitiesParticipatedIn[indexPath.row]
//            if let activitycell = cell as? OtherHomePageTableViewCell {
//                activitycell.activity = activityPreview
//            }
//            break
//        case 1:
//            cell = activityTable.dequeueReusableCell(withIdentifier: "OtherUserActivities", for: indexPath)
//            let activityPreview = activitiesRelease[indexPath.row]
//            if let activitycell = cell as? OtherHomePageTableViewCell {
//                activitycell.activity = activityPreview
//            }
//            break
//        default:
//            break
//        }
//        return cell!
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
