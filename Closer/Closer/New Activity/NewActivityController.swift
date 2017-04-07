//
//  NewActivityController.swift
//  Closer
//
//  Created by Kami on 2017/2/20.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

class NewActivityController: UIViewController {
    
    static let bgColor = UIColor(red:0.96, green:0.65, blue:0.14, alpha:0.2)
    
    static let bgColorTransparent = UIColor(red:0.96, green:0.65, blue:0.14, alpha:0)
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
// = {
//        let pc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        let pcAppearance = UIPageControl.appearance()
//        pcAppearance.pageIndicatorTintColor = .lightGray
//        pcAppearance.backgroundColor = .red
//        return pc
//    }()
    
    let nameViewController = NewActivityNameViewController()
    let authViewController = NewActivityAuthorizationViewController()
    let timeLocationTagViewController = NewActivityTimeLocationViewController()
    let descriptionViewController = NewActivityDescriptionViewController()
    
    var pages = [UIViewController]()
    let dbRef = FIRDatabase.database().reference()
    let currUser = FIRAuth.auth()?.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布任务"
        pageViewController.delegate = self
        pageViewController.dataSource = self
        view.backgroundColor = .white
        setupViewControllers()
        setupReleaseButton()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewActivityController.exitSearchMode))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red:0.35, green:0.34, blue:0.34, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    private func setupReleaseButton() {
        let releaseButton = UIButton(type: .system)
        releaseButton.frame = CGRect(x: 0.0, y: 8.0, width: 30, height: 30)
        releaseButton.setImage(#imageLiteral(resourceName: "release-icon"), for: .normal)
        releaseButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        releaseButton.addTarget(self, action: #selector(touchRelease), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: releaseButton)
    }
    
    func touchRelease() {
        guard let name = nameViewController.getName(), let auth = authViewController.getAuth(), let location = timeLocationTagViewController.getLocation()
            else {
                return
        }
        
        let activityId = dbRef.child("activities").childByAutoId().key
        var activity = ["name": name,
                        "authorization": auth,
                        "releasingUserID": currUser?.uid ?? "unkonwn",
                        "releasingUserName": currUser?.displayName ?? "unknown",
                        "locationName": location,
                        "numberOfParticipants": 0] as [String : Any]
        
        var assignedParticipants = [String: Int]()
        if auth == "OnlyAssignedFriendsOrContacts" {
            let names = authViewController.getTextFieldText(byPlaceholder: "请输入好友或联系人姓名")
            if let names = names {
                let nameArr = names.characters.split(separator: ",").map(String.init)
                for name in nameArr {
                    assignedParticipants[name] = 1
                }
            }
            activity["assignedParticipants"] = assignedParticipants
        }
        
        let categories = timeLocationTagViewController.getCategories()
        if categories != nil {
            activity["categories"] = categories
        }
        
        if let tags = timeLocationTagViewController.getTags() {
            activity["tags"] = tags
        }
        
        if let start = timeLocationTagViewController.getStartingTime() {
            activity["timeStartStamp"] = start.timeIntervalSince1970
        }
        
        if let end = timeLocationTagViewController.getEndTime() {
            activity["timeEndStamp"] = end.timeIntervalSince1970
        }
        
        activity["timeReleaseStamp"] = Date().timeIntervalSince1970
        
        let description = descriptionViewController.getDescription()
        formatDescription(activityId: activityId, description: description)
        //        var descriptionDic = [String: [String: String]]()
        //        var index: Int = 0
        //        for unit in description {
        //            descriptionDic[String(index)] = ["type": unit.type,
        //                                             "content": unit.content]
        //            index += 1
        //        }
        //        activity["description"] = descriptionDic

        
        let briefActivity = ["name": name] as [String : Any]
        let updates = ["activities/\(activityId)": activity,
                       "users/\(currUser!.uid)/activities/\(activityId)": briefActivity]
//        dbRef.updateChildValues(updates)
        dbRef.updateChildValues(updates) { (error, dbRef) in
            if error != nil {
                print(error ?? "Error!")
                return
            }
            if categories != nil {
                self.addCategoryInformation(activityId: activityId, categories: categories!)
            }
            self.formatDescription(activityId: activityId, description: description)
        }
//        dbRef.updateChildValues(["newActivities/\(activityId)/assignedParticipants": assignedParticipants])
        let _ = navigationController?.popViewController(animated: true)
    }
    
    private func addCategoryInformation(activityId: String, categories: String) {
        let categoryDbRef = FIRDatabase.database().reference().child("category-activities")
        let categoryArr = categories.characters.split{$0 == ","}.map(String.init)
        for category in categoryArr {
            categoryDbRef.updateChildValues(["\(category.lowercased().trimmingCharacters(in: .whitespaces))/\(activityId)": 0])
        }
    }
    
    func formatDescription(activityId: String, description: NSAttributedString) {
//        formattedDescription = [DescriptionUnit]()
        if description == NSAttributedString(string: "") {
            return
        } else {
            let range = NSMakeRange(0, description.length)
            var index: Int = 0
            description.enumerateAttributes(in: range, options: [], using: { (attributesDic, range, pointer) in
                if let attachments = attributesDic as? NSDictionary {
                    let pureString = description.attributedSubstring(from: range).string
                    var isImage = false
                    for (key, obj) in attachments {
                        if let type = key as? NSString {
//                            print(type)
                            if type == "NSAttachment" {
                                let att = obj as! NSTextAttachment
                                if att.image != nil {
                                    isImage = true
                                    uploadImageToFirebase(activityId: activityId, image: att.image!, index: index)
                                }
                            }
                        }
                    }
                    if isImage == false {
                        let descriptionUnit = ["type": ContentType.Text.rawValue,
                                               "content": pureString]
                        let updates = ["activities/\(activityId)/description/\(index)": descriptionUnit,
                                       "users/\(currUser!.uid)/activities/\(activityId)/description/\(index)": descriptionUnit]
                        dbRef.updateChildValues(updates)
                    }
                }
                index += 1
            })
        }
    }
    
    private func uploadImageToFirebase(activityId: String, image: UIImage, index: Int) {
        var downloadUrlString: String?
        //        let data: Data = UIImagePNGRepresentation(image)!
        let data = UIImageJPEGRepresentation(image, 0.7)!
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("activity-images").child("\(imageName).png")
        storageRef.put(data as Data, metadata: metaData) { (storageMetadata, error) in
            if error != nil {
                print(error ?? "Error!")
                return
            }
            downloadUrlString = storageMetadata?.downloadURL()?.absoluteString
            if downloadUrlString != nil {
                self.updateFormattedDescription(activityId: activityId, type: ContentType.Image, downloadUrl: downloadUrlString!, index: index)
            }
        }
    }
    
    private func updateFormattedDescription(activityId: String, type: ContentType, downloadUrl: String, index: Int) {
        let descriptionUnit = ["type": type.rawValue,
                               "content": downloadUrl]
        let updates = ["activities/\(activityId)/description/\(index)": descriptionUnit,
                       "users/\(currUser!.uid)/activities/\(activityId)/description/\(index)": descriptionUnit]
        dbRef.updateChildValues(updates)
    }


    private func setupViewControllers() {
        self.addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        let pcAppearance = UIPageControl.appearance()
        pcAppearance.pageIndicatorTintColor = .lightGray
        pcAppearance.backgroundColor = .white
        
        pageViewController.setViewControllers([nameViewController], direction: .forward, animated: true) { (flag) in
        }
        pages.append(nameViewController)
        pages.append(authViewController)
        pages.append(timeLocationTagViewController)
        pages.append(descriptionViewController)
//        pageViewController.didMove(toParentViewController: self)
    }
    
    @objc private func exitSearchMode() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension NewActivityController: UIPageViewControllerDelegate {
    
}

extension NewActivityController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case nameViewController:
            return authViewController
        case authViewController:
            return timeLocationTagViewController
        case timeLocationTagViewController:
            return descriptionViewController
        default:
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        switch viewController {
        case descriptionViewController:
            return timeLocationTagViewController
        case timeLocationTagViewController:
            return authViewController
        case authViewController:
            return nameViewController
        default:
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        print(pages.count)
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    
    }
    
}
