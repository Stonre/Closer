//
//  DCTabBarController.swift
//  Closer
//
//  Created by Kami on 2017/1/14.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class DCTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let newActivityButton = UIButton(type: .contactAdd)
    let homeButton = UIButton()
    let chatButton = UIButton()
    
    let tabBarItemImageSize = CGSize(width: 24, height: 24)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        delegate = self
    }
    
    private func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let discoverViewController = DiscoverViewController()
        let discoverIcon = resizeImage(image: #imageLiteral(resourceName: "discover-icon"), newSize: tabBarItemImageSize)
//        di = CGSize(width: 24, height: 24)
        discoverViewController.tabBarItem = UITabBarItem(title: "发现", image: discoverIcon, selectedImage: nil)
        
        let circleIcon = resizeImage(image: #imageLiteral(resourceName: "circle-icon"), newSize: tabBarItemImageSize)
        let circleViewController = CircleTableViewController()
        circleViewController.tabBarItem = UITabBarItem(title: "圈子", image: circleIcon, selectedImage: nil)
        viewControllers = [discoverViewController, circleViewController]
    }
    
    private func setupNavigationBar() {
        setupMainPageButton()
        setupChatButton()
        setupNewActivityButton()
    }
    
    private func setupNewActivityButton() {
        view.addSubview(newActivityButton)
        newActivityButton.backgroundColor = .white
        newActivityButton.translatesAutoresizingMaskIntoConstraints = false
        
        newActivityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newActivityButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor).isActive = true
        
        newActivityButton.addTarget(self, action: #selector(touchNewActivity), for: .touchUpInside)
    }
    
    func touchNewActivity() {
        
        navigationController?.pushViewController(NewActivityController(), animated: true)
        
    }
    
    private func setupMainPageButton() {
        homeButton.frame = CGRect(origin: CGPoint(x: 8, y:8), size: DiscoverViewController.buttomSize)
        homeButton.setImage(#imageLiteral(resourceName: "home-icon"), for: .normal)
        homeButton.addTarget(self, action: #selector(touchHome(_:)), for: .touchUpInside)
        
        let leftBarItem = UIBarButtonItem(customView: homeButton)
        navigationItem.leftBarButtonItem = leftBarItem
        
    }
    
    func touchHome(_ sender: UIButton) {
        self.navigationController?.pushViewController(HomePageController(), animated: true)
    }
    
    private func setupChatButton() {
        chatButton.frame = CGRect(origin: CGPoint(x: 8, y: 8), size: DiscoverViewController.buttomSize)
        chatButton.setImage(#imageLiteral(resourceName: "chat-icon"), for: .normal)
        chatButton.addTarget(self, action: #selector(touchChat(_:)), for: .touchUpInside)
        chatButton.addTarget(self, action: #selector(doubleTouchChat(_:)), for: .touchUpOutside)
        
        let rightBarItem = UIBarButtonItem(customView: chatButton)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func doubleTouchChat(_ sender: UIButton) {
        self.navigationController?.pushViewController(AllUserViewcontroller(), animated: true)
    }
    
    func touchChat(_ sender: UIButton) {
        self.navigationController?.pushViewController(ChatListViewController(), animated: true)
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
