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

    var activities = [Array<Activity>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? {
        didSet {
            searchText = searchText?.lowercased()
            activities.removeAll()
            searchForActivities()
        }
    }
    
    var dbRef = FIRDatabase.database().reference(fromURL: "https://closer-17ee2.firebaseio.com/")
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
            let act = GeneralActivity(name: "\(currUserName)'s Activity \(i)", tags: [], authority: Authority.FriendsAndContacts, description: Description(txt: description), userReleasing: PersonalUserForView(userName: currUserName, userId: 0, gender: Gender.Female, age: 18), identity: UInt64(i))
            let key = dbRef.child("activities").childByAutoId().key
            let activity = ["releasingUserID": currUserID,
                            "releasingUserName": currUserName,
                            "name": act.name,
                            "discription": act.description.text]
            let updates = ["activities/\(key)": activity,
                           "users/\(currUserID)/activities/\(key)": ["name": act.name,
                                                                     "discription": act.description.text]]
            dbRef.updateChildValues(updates)
        }

    }
    
    private func handleLogout() {
        DCViewController().handleLogout()
    }
    
    private func searchForActivities() {
        if searchText == "default" {
            var defaultSection = [Activity]()
            for i in 1...15 {
                var description = ""
                for _ in 1...i{
                    description += "This is Activity \(i) "
                }
                defaultSection.append(GeneralActivity(name: "Activity \(i)", tags: [], authority: Authority.FriendsAndContacts, description: Description(txt: description), userReleasing: PersonalUserForView(userName: "User \(i)", userId: 0, gender: Gender.Female, age: 18), identity: UInt64(i)))
            }
            activities.append(defaultSection)
        } else {
            fetchActivities()
        }
    }
    
    private func fetchActivities() {
        dbRef.child("activities").observeSingleEvent(of: .value, with: { (snapshot) in
            var activitiesSection = [Activity]()
            let value = snapshot.value as? NSDictionary ?? NSDictionary()
            for (_, activity) in value {
                if let act = activity as? NSDictionary {
                    let actName = act["name"] as? String ?? ""
                    if actName.lowercased().contains(self.searchText!) {
                        let releasingUserID = act["releasingUserID"] as? String ?? ""
                        let actDiscription = act["discription"] as? String ?? ""
                        let releasingUserName = act["releasingUserName"] as? String ?? ""
                        let generalActivity = GeneralActivity(name: actName, tags: [], authority: Authority.FriendsAndContacts, description: Description(txt: actDiscription), userReleasing: PersonalUserForView(userName: releasingUserName, userId: 0, gender: Gender.Female, age: 18), identity: UInt64(1))
                        activitiesSection.append(generalActivity)
                    }
                }
            }
            self.activities.append(activitiesSection)
        }){ (error) in
            print(error.localizedDescription)
        }
        return
    }
    
    private func setupNavigationBarTitle() {
        if let _ = self as? DiscoverViewController {
            tabBarController?.navigationItem.title = "发现"
        } else {
            tabBarController?.navigationItem.title = "圈子"
        }
//        tabBarController?.navigationItem.title = CircleTableViewController.viewTitle
    }
    
//    private func setupMainPageButton() {
//        let homeButton = UIButton()
//        homeButton.frame = CGRect(origin: CGPoint(x: 8, y:8), size: DiscoverViewController.buttomSize)
//        homeButton.setImage(#imageLiteral(resourceName: "home-icon"), for: .normal)
//        homeButton.addTarget(self, action: #selector(touchHome(_:)), for: .touchUpInside)
//        
//        let leftBarItem = UIBarButtonItem(customView: homeButton)
//        tabBarController?.navigationItem.leftBarButtonItem = leftBarItem
//    }
//
//    func touchHome(_ sender: UIButton) {
//        //replace controller with Homepage controller
//        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
//        if let controller = storyboard.instantiateInitialViewController() as? UINavigationController {
//            //            tabBarController?.tabBar.isHidden = true
//            navigationController!.pushViewController(controller.visibleViewController!, animated: true)
//        }
//    }
//    
//    private func setupChatButton() {
//        let chatButton = UIButton()
//        chatButton.frame = CGRect(origin: CGPoint(x: 8, y:8), size: DiscoverViewController.buttomSize)
//        chatButton.setImage(#imageLiteral(resourceName: "chat-icon"), for: .normal)
//        chatButton.addTarget(self, action: #selector(touchChat(_:)), for: .touchUpInside)
//        
//        let rightBarItem = UIBarButtonItem(customView: chatButton)
//        tabBarController?.navigationItem.rightBarButtonItem = rightBarItem
//    }
//    
//    func touchChat(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
//        if let controller = storyboard.instantiateInitialViewController() as? UINavigationController {
//            //tabBarController?.tabBar.isHidden = true
//            navigationController!.pushViewController(controller.visibleViewController!, animated: true)
//        }
//    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        currUser = FIRAuth.auth()?.currentUser
        tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        setupNavigationBarTitle()
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.cellReuseID)
        tableView.tableFooterView?.isHidden = false
        searchText = currUser?.displayName!.lowercased()
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 100
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.cellReuseID, for: indexPath)

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
            
            let estimatedActivityDescriptionFrame = NSString(string: act.description.text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)], context: nil)
            
            let estimatedActivityDescriptionFrameHeight = min(130, estimatedActivityDescriptionFrame.height + 10)
            
            let estimatedHeight = max(80, estimatedUserNameFrame.height + estimatedActivityNameFrame.height + estimatedActivityDescriptionFrameHeight)
            
            return estimatedHeight
        }

        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
