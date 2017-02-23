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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布任务"
        pageViewController.delegate = self
        pageViewController.dataSource = self
        view.backgroundColor = .white
        setupViewControllers()
        setupReleaseButton()
        // Do any additional setup after loading the view.
    }
    
    private func setupReleaseButton() {
        let releaseButton = UIButton(type: .system)
        releaseButton.frame = CGRect(x: 8.0, y: 8.0, width: 60, height: 28)
        releaseButton.setTitle("发布", for: .normal)
        releaseButton.addTarget(self, action: #selector(touchRelease), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: releaseButton)
    }
    
    func touchRelease() {
        guard let name = nameViewController.getName(), let auth = authViewController.getAuth(), let description = descriptionViewController.getDescription(), let currUser = FIRAuth.auth()?.currentUser, let location = timeLocationTagViewController.getLocation()
            else {
                return
        }
        
        let dbRef = FIRDatabase.database().reference()
        let activityId = dbRef.child("newActivities").childByAutoId().key
        var activity = ["name": name,
                        "description": description,
                        "authorization": auth,
                        "releasingUserID": currUser.uid,
                        "releasingUserName": currUser.displayName,
                        "locationName": location]
        if let tags = timeLocationTagViewController.getTags() {
            activity["tags"] = tags
        }
        
        if let start = timeLocationTagViewController.getStartingTime() {
            activity["startingTime"] = String(start.timeIntervalSince1970)
        }
        
        if let end = timeLocationTagViewController.getEndTime() {
            activity["endingTime"] = String(end.timeIntervalSince1970)
        }
        
        let briefActivity = ["name": name,
                             "description": description]
        let updates = ["newActivities/\(activityId)": activity,
                       "users/\(currUser.uid)/activities/\(activityId)": briefActivity]
        dbRef.updateChildValues(updates)
        navigationController?.popViewController(animated: true)
    }

    private func setupViewControllers() {
        self.addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        let pcAppearance = UIPageControl.appearance()
        pcAppearance.pageIndicatorTintColor = .lightGray
        pcAppearance.backgroundColor = .red
        
        pageViewController.setViewControllers([nameViewController], direction: .forward, animated: true) { (flag) in
        }
        pages.append(nameViewController)
        pages.append(authViewController)
        pages.append(timeLocationTagViewController)
        pages.append(descriptionViewController)
//        pageViewController.didMove(toParentViewController: self)
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
