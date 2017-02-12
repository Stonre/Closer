//
//  DCViewController.swift
//  Closer
//
//  Created by Kami on 2017/1/23.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

class DCViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if FIRAuth.auth()?.currentUser != nil {
            pushViewController(DCTabBarController(), animated: true)
        } else {
            handleLogout()
        }
    }

    func handleLogout() {
        do{
         try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print("Sign out error %@", error)
        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = LoginViewController()
        }
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
