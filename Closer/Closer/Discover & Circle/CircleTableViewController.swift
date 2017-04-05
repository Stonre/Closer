//
//  CircleTableTableViewController.swift
//  Closer
//
//  Created by Kami on 2017/1/6.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import UIKit
import Firebase

class CircleTableViewController: UITableViewController {
    
    var currUser: FIRUser? {
        didSet{
            if currUser == nil {
                handleLogout()
            }
        }
    }

    var newActivities = [Activity]()
    var activities = [Array<Activity>]() {
        didSet {
            tableView.reloadData()
        }
    }
    var updateInfoLabel = UILabel()
    
    var searchText: String? {
        didSet {
            searchText = searchText?.lowercased() // 
            activities.removeAll()
            searchForActivities()
        }
    }
    
    var dbRef = FIRDatabase.database().reference()
    func createActivities() {
        guard let currUserID = currUser?.uid, let currUserName = currUser?.displayName
            else {
                print("Cannot create activity!")
                return
        }
        for i in 1...15 {
            var description = ""
            for _ in 1...i{
                description += "This is Activity \(i) "
            }
            let du = DescriptionUnit(type: ContentType.Text.rawValue, content: description)
            let act = GeneralActivity(name: "\(currUserName)'s Activity \(i)", tags: [], authority: Authority.FriendsAndContacts, description: [du], userReleasing: PersonalUserForView(userName: currUserName, userId: currUserID, gender: Gender.Female, age: 18), identity: currUserID)
            let key = dbRef.child("activities").childByAutoId().key
            let activity = ["releasingUserID": currUserID,
                            "releasingUserName": currUserName,
                            "name": act.name,
                            "description": act.description.first?.content]
            let updates = ["activities/\(key)": activity,
                           "users/\(currUserID)/activities/\(key)": ["name": act.name,
                                                                     "description": act.description.first?.content]]
            dbRef.updateChildValues(updates)
        }

    }
    
    private func handleLogout() {
        DCViewController().handleLogout()
    }
    
    func searchForActivities() {
        if searchText == "default" {
            var defaultSection = [Activity]()
            for i in 1...15 {
                var description = ""
                for _ in 1...i{
                    description += "This is Activity \(i) "
                }
                defaultSection.append(GeneralActivity(name: "Activity \(i)", tags: [], authority: Authority.FriendsAndContacts, description: [DescriptionUnit(type: ContentType.Text.rawValue, content: description)], userReleasing: PersonalUserForView(userName: "User \(i)", userId: (currUser?.uid)!, gender: Gender.Female, age: 18), identity: "not set"))
            }
            activities.append(defaultSection)
        } else {
            fetchActivities()
        }
    }
    
    private func fetchActivities() {
        dbRef.child("activities").observeSingleEvent(of: .value, with: { (snapshot) in
//            var activitiesSection = [Activity]()
            let value = snapshot.value as? NSDictionary ?? NSDictionary()
            for (activityId, _) in value {
                let fetchs = FetchData.sharedInstance
                fetchs.fetchGeneralActivtiy(activityid: activityId as! String) { (activity) in
                    var activitiesSection = [Activity]()
                    activitiesSection.append(activity)
                    self.activities.append(activitiesSection)
                }
            }
//            self.activities.append(activitiesSection)
        }){ (error) in
            print(error.localizedDescription)
        }
        return
    }
    
    private func keepUpdatingActivities() {
        dbRef.child("activities").observe(.childChanged, with: { (snapshot) in
            var activitiesSection = [Activity]()
            let value = snapshot.value as? NSDictionary ?? NSDictionary()
            for (_, activity) in value {
                if let act = activity as? NSDictionary {
                    let actName = act["name"] as? String ?? ""
                    if actName.lowercased().contains(self.searchText!) {
                        self.newActivities.append(self.dictionary2GeneralActivity(dictionary: act)!)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        return
    }
    
    private func setupUpdateInfoLabel() {
        view.addSubview(updateInfoLabel)
        updateInfoLabel.font = UIFont.preferredFont(forTextStyle: .body)
        updateInfoLabel.textAlignment = .center
        updateInfoLabel.backgroundColor = .green
        updateInfoLabel.isHidden = true
        
        updateInfoLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 24)
        
//        updateInfoLabel.translatesAutoresizingMaskIntoConstraints = false
//        updateInfoLabel.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 0).isActive = true
//        updateInfoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        updateInfoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
//        updateInfoLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func dictionary2GeneralActivity(dictionary: NSDictionary) -> GeneralActivity? {
//        let releasingUserID = dictionary["releasingUserID"] as? String ?? ""
        let actDescription = dictionary["description"] as? String ?? ""
        let releasingUserName = dictionary["releasingUserName"] as? String ?? ""
        let releasingUserId = dictionary["releasingUserID"] as? String ?? ""
        let actName = dictionary["name"] as? String ?? ""
        return GeneralActivity(name: actName, tags: [], authority: Authority.FriendsAndContacts, description: [DescriptionUnit(type: ContentType.Text.rawValue, content: actDescription)], userReleasing: PersonalUserForView(userName: releasingUserName, userId: releasingUserId, gender: Gender.Female, age: 18), identity: "not set")
        
    }
    
    private func setupNavigationBarTitle() {
        if let _ = self as? DiscoverViewController {
            tabBarController?.navigationItem.title = "发现"
        } else {
            tabBarController?.navigationItem.title = "圈子"
        }
//        tabBarController?.navigationItem.title = CircleTableViewController.viewTitle
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isTranslucent = true
        currUser = FIRAuth.auth()?.currentUser
        tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        setupNavigationBarTitle()
        tableView.register(ActivityCell.self, forCellReuseIdentifier: CloserUtility.ActivityCellReuseId)
        tableView.tableFooterView?.isHidden = false
//        searchText = currUser?.displayName!.lowercased()
        searchText = ""
        setupRefreshControl()
        keepUpdatingActivities()
        setupUpdateInfoLabel()
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 100
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    private func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = .red
        self.refreshControl?.addTarget(self, action: #selector(getLatestActivities), for: .valueChanged)
    }
    
    func getLatestActivities() {
        if (self.refreshControl != nil) {
            var title = "refreshing"
            self.refreshControl?.attributedTitle = NSAttributedString(string: title)
            updateInfoLabel.text = "已更新\(newActivities.count)条活动"
            view.bringSubview(toFront: updateInfoLabel
            )
            let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(hideUpdateInfoLabel), userInfo: nil, repeats: false)
            if newActivities.count == 0 {
                self.refreshControl?.endRefreshing()
                updateInfoLabel.isHidden = false
                return
            }
            activities.insert(newActivities, at: 0)
            newActivities.removeAll()
            self.refreshControl?.endRefreshing()
            updateInfoLabel.isHidden = false
        }
    }
    
    func hideUpdateInfoLabel() {
        updateInfoLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarTitle()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
            return activities.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CloserUtility.ActivityCellReuseId, for: indexPath)

        let currAcvitity = activities[indexPath.section][indexPath.row]
        if let activityCell = cell as? ActivityCell {
            activityCell.userProfileImage = #imageLiteral(resourceName: "sampleHeaderPortrait2")
            activityCell.activity = currAcvitity
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currAcvitity = activities[indexPath.section][indexPath.row]

        if let act = currAcvitity as? GeneralActivity{
            let size = CGSize(width: tableView.bounds.width - 90, height: 1000)
            
            let estimatedUserNameFrame = NSString(string: act.userReleasing.userName).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)], context: nil)
            
            let estimatedActivityNameFrame = NSString(string: act.name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)], context: nil)
            
            var estimatedActivityDescriptionFrame = CGRect.zero
            if act.description.count > 0 {
                estimatedActivityDescriptionFrame = NSString(string: (act.description.first?.content)!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)], context: nil)
            }
            
            let estimatedActivityDescriptionFrameHeight = min(130, estimatedActivityDescriptionFrame.height + 10)
            
            let estimatedHeight = max(80, estimatedUserNameFrame.height + estimatedActivityNameFrame.height + estimatedActivityDescriptionFrameHeight)
            
            return estimatedHeight
        }

        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activityReviewViewController = FullActivityReviewViewController()
        activityReviewViewController.activity = activities[indexPath.section][indexPath.row]
        navigationController?.pushViewController(activityReviewViewController, animated: true)
        return
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
