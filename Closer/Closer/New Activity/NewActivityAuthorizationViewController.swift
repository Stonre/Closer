//
//  NewActivityAuthorizationViewController.swift
//  Closer
//
//  Created by Kami on 2017/2/20.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class NewActivityAuthorizationViewController: NewActivityContentViewController {
    
    let titleLabel = UILabel()
    let authorizationRadioButtons = RadioButtonsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        contentIndex = 1
        setupTitleLabel()
        setupAuthorizationRadioButtons()
        // Do any additional setup after loading the view.
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
        titleLabel.text = "任务权限："
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }

    private func setupAuthorizationRadioButtons() {
        authorizationRadioButtons.addOption(optionName: "指定好友或联系人", withTextFieldPlaceholder: "请输入好友或联系人姓名")
        authorizationRadioButtons.addOption(optionName: "好友可见")
        authorizationRadioButtons.addOption(optionName: "联系人可见")
        authorizationRadioButtons.addOption(optionName: "好友和联系人可见")
        authorizationRadioButtons.addOption(optionName: "公开")
//        authorizationRadioButtons.view.isUserInteractionEnabled = true
//        authorizationRadioButtons.view.backgroundColor = .yellow
//        authorizationRadioButtons.view.addGestureRecognizer(UITapGestureRecognizer(target: authorizationRadioButtons, action: #selector(authorizationRadioButtons.touchButton)))
        self.addChildViewController(authorizationRadioButtons)
        view.addSubview(authorizationRadioButtons.view)
        
        authorizationRadioButtons.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        authorizationRadioButtons.view.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        authorizationRadioButtons.view.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        authorizationRadioButtons.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func getAuth() -> String? {
        if let selectedAuthName = authorizationRadioButtons.getSelectedButtonName() {
            switch selectedAuthName {
            case "指定好友或联系人":
                return "OnlyAssignedFriendsOrContacts"
            case "好友可见":
                return "OnlyFriends"
            case "联系人可见":
                return "OnlyContacts"
            case "好友和联系人可见":
                return "FriendsAndContacts"
            case "公开":
                return "Public"
            default: break
            }
        }
        return nil
    }
    
    func getTextFieldText(byPlaceholder placeholder: String) -> String? {
        return authorizationRadioButtons.getTextFieldText(byPlaceholder: placeholder)
    }
}
