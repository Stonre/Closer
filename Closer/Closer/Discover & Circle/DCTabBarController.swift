//
//  DCTabBarController.swift
//  Closer
//
//  Created by Kami on 2017/1/14.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class DCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        setupMainPageButton()
        setupChatButton()
    }
    
    private func setupMainPageButton() {
        let homeButton = UIButton()
        homeButton.frame = CGRect(origin: CGPoint(x: 8, y:8), size: DiscoverViewController.buttomSize)
        homeButton.setImage(#imageLiteral(resourceName: "home-icon"), for: .normal)
        homeButton.addTarget(self, action: #selector(touchHome(_:)), for: .touchUpInside)
        
        let leftBarItem = UIBarButtonItem(customView: homeButton)
        navigationItem.leftBarButtonItem = leftBarItem
        
    }
    
    func touchHome(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() as? UINavigationController {
            //            tabBarController?.tabBar.isHidden = true
            navigationController!.pushViewController(controller.visibleViewController!, animated: true)
        }
    }
    
    private func setupChatButton() {
        let chatButton = UIButton()
        chatButton.frame = CGRect(origin: CGPoint(x: 8, y:8), size: DiscoverViewController.buttomSize)
        chatButton.setImage(#imageLiteral(resourceName: "chat-icon"), for: .normal)
        chatButton.addTarget(self, action: #selector(touchChat(_:)), for: .touchUpInside)
        
        let rightBarItem = UIBarButtonItem(customView: chatButton)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func touchChat(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() as? UINavigationController {
            tabBarController?.tabBar.isHidden = true
            navigationController!.pushViewController(controller.visibleViewController!, animated: true)
        }
        
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
