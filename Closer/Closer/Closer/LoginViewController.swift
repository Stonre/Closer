//
//  LoginViewController.swift
//  Closer
//
//  Created by Kami on 2016/12/25.
//  Copyright © 2016年 Kami. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchLogin(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Discover", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() as UIViewController? {
            self.present(controller, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
