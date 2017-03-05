//
//  SettingsController.swift
//  Closer
//
//  Created by Lei Ding on 3/4/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

class SettingsController: UITableViewController {
    
    struct Section {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    var objectArray = [
        Section(sectionName: "账号管理", sectionObjects: ["个人信息", "个人物品", "绑定账号"]),
        Section(sectionName: "关于软件", sectionObjects: ["关于Closer", "联系我们"]),
        Section(sectionName: "退出登录", sectionObjects: ["退出登录"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.cellReuseId)
        self.navigationItem.title = "设置"
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellReuseId, for: indexPath)
        
        // Configure the cell
        if let settingsCell = cell as? SettingsCell {
            settingsCell.name = objectArray[indexPath.section].sectionObjects[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectArray[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        switch section {
        case 0:
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 26)
            headerView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:0.6)
            let name = UILabel()
            name.text = "账户管理"
            name.frame = CGRect(x: 24, y: 0, width: tableView.frame.size.width, height: 30)
            name.font = UIFont.systemFont(ofSize: 12)
            headerView.addSubview(name)
        case 1:
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 26)
            headerView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:0.6)
            let name = UILabel()
            name.text = "关于软件"
            name.frame = CGRect(x: 24, y: 0, width: tableView.frame.size.width, height: 30)
            name.font = UIFont.systemFont(ofSize: 12)
            headerView.addSubview(name)
        case 2:
            headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        default:
            break
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 24)
        footerView.backgroundColor = .white
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            break
        case 2:
            handleLogout()
        default:
            break
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
}

class SettingsCell: UITableViewCell {
    
    static let cellReuseId = "SettingsCell"
    
    var name: String? {
        didSet {
            nameLabel.text = name
            if name == "退出登录" {
                nameLabel.textAlignment = .center
                nameLabel.font = UIFont.systemFont(ofSize: 20)
                nameLabel.textColor = .white
                nameLabel.backgroundColor = UIColor(red:0.87, green:0.39, blue:0.39, alpha:1.0)
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
}

