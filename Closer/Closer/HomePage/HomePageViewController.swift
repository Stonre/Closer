//
//  HomePageViewController.swift
//  Closer
//
//  Created by Lei Ding on 1/12/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit

struct UserSample {
    var userName: String?
    var headPortrait: UIImage?
    var activitiesParticipatedIn = [ActivitySample]()
    var activitiesRelease = [ActivitySample]()
}

struct ActivitySample {
    var activityName: String?
    var activityContent: String?
    var releaser: UserSample?
}

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var contacts = [UserSample]()
    var friends = [UserSample]()
    var activitiesParticipatedIn = [ActivitySample]()
    var activitiesRelease = [ActivitySample]()
    var selectState = 0 {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var myBackground: UIImageView!
    
    @IBOutlet weak var headPortrait: UIImageView!
    
    @IBOutlet weak var nickName: UILabel!
    
    @IBOutlet weak var myWords: UILabel!
    
    @IBAction func moreButton(_ sender: UIButton) {
    }
    
    @IBAction func activityParticipatedInButton(_ sender: UIButton) {
        selectState = 0
    }

    @IBAction func activityReleaseButton(_ sender: UIButton) {
        selectState = 1
    }
    
    @IBAction func friendsButton(_ sender: UIButton) {
        selectState = 2
    }
    
    @IBAction func contactsButton(_ sender: UIButton) {
        selectState = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSampleData()
        setupLogoutButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    private func setupLogoutButton() {
        let logoutTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchLogout))
        logoutTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(logoutTapRecognizer)
//        let logoutButton = UIButton(type: .system)
//        logoutButton.frame = CGRect(origin: CGPoint(x: 8, y: 8), size: DiscoverViewController.buttomSize)
//        logoutButton.setTitle("Logout", for: .normal)
//        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }
    
    func touchLogout() {
        DCViewController().handleLogout()
//        navigationController?.present(LoginViewController(), animated: true, completion: nil)
    }
    
    private func initSampleData() {
        //for sample users
        let contactsName: [String] = ["Yi Zhou", "Yi Ding", "Peter"]
        let friendsName: [String] = ["Zenith", "Zack", "Kami"]
        let contactsHeader: [String] = ["sampleHeaderPortrait1", "sampleHeaderPortrait2", "sampleHeaderPortrait3"]
        let friendsHeaer: [String] = ["sampleHeaderPortrait4", "sampleHeaderPortrait5", "sampleHeaderPortrait6"]
        var user = UserSample()
        for i in 0...2 {
            user.userName = contactsName[i]
            user.headPortrait = UIImage(named: contactsHeader[i])
            contacts.append(user)
            user.userName = friendsName[i]
            user.headPortrait = UIImage(named: friendsHeaer[i])
            friends.append(user)
        }
        
        //for sample activities
        let activityPName: [String] = ["activity 1", "activity 2", "activity 3"]
        let activityRName: [String] = ["activity 1", "activity 2", "activity 3"]
        let activityPContent: [String] = ["This is activity 1's content", "This is activity 2's content", "This is activity 3's content"]
        let activityRContent: [String] = ["This is activity 1's content", "This is activity 2's content", "This is activity 3's content"]
        var activity = ActivitySample()
        for i in 0...2 {
            activity.activityName = activityPName[i]
            activity.activityContent = activityPContent[i]
            activity.releaser = friends[i]
            activitiesParticipatedIn.append(activity)
            activity.activityName = activityRName[i]
            activity.activityContent = activityRContent[i]
            activity.releaser = contacts[i]
            activitiesRelease.append(activity)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectState {
        case 0:
            return activitiesParticipatedIn.count
        case 1:
            return activitiesRelease.count
        case 2:
            return friends.count
        case 3:
            return contacts.count
        default:
            return friends.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch selectState {
        case 0:
            print("kami")
            cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
            let activityPreview = activitiesParticipatedIn[indexPath.row]
            if let activitycell = cell as? ActivityPreviewTableViewCell {
                activitycell.activity = activityPreview
            }
            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
            let activityPreview = activitiesRelease[indexPath.row]
            if let activitycell = cell as? ActivityPreviewTableViewCell {
                activitycell.activity = activityPreview
            }
            break
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "OtherUserHomePage", for: indexPath)
            let otherUserPreview = friends[indexPath.row]
            if let otherUserCell = cell as? OtherUserTableViewCell {
                otherUserCell.user = otherUserPreview
            }
            break
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "OtherUserHomePage", for: indexPath)
            let otherUserPreview = contacts[indexPath.row]
            if let otherUserCell = cell as? OtherUserTableViewCell {
                otherUserCell.user = otherUserPreview
            }
            break
        default:
            break
        }
        return cell!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
