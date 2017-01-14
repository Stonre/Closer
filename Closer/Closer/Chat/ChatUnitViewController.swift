//
//  ChatUnitViewController.swift
//  CloserChat
//
//  Created by z on 2017/1/8.
//  Copyright © 2017年 Closer. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatUnitViewController: JSQMessagesViewController {
    
    var chatRef: FIRDatabaseReference?
    var personalChat: PersonalChat? {
        didSet {
            title = personalChat?.person.userNickname
        }
    }
    
    var eventChat: EventChat? {
        didSet {
            title = eventChat?.eventName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = "1"

        // Do any additional setup after loading the view.
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
