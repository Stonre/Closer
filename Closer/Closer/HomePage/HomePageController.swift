//
//  HomePageController.swift
//  Closer
//
//  Created by Lei Ding on 2/2/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit
import CoreLocation

class HomePageController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tarBarSelect = 0 {
        didSet{
            tableView.reloadData()
        }
    }//tar
    
    let basicInfoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let portraitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "sampleHeaderPortrait5")
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "mybackground")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNameView: UILabel = {
        let nameView = UILabel()
        nameView.text = "小凯凯"
        nameView.textAlignment = .center
        nameView.font = UIFont.boldSystemFont(ofSize: 18)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        return nameView
    }()
    
    let signature: UILabel = {
        let signatureView = UILabel()
        signatureView.text = "我就是我，一个闷骚而优秀的男人"
        signatureView.textAlignment = .center
        signatureView.font = UIFont.systemFont(ofSize: 14)
        signatureView.translatesAutoresizingMaskIntoConstraints = false
        return signatureView
    }()
    
    let moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        return moreButton
    }()
    
    let fortuneButton: UIButton = {
        let fortuneButton = UIButton()
        fortuneButton.translatesAutoresizingMaskIntoConstraints = false
        return fortuneButton
    }()
    
    let friendsButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "好友"), for: .normal)
        button.addTarget(self, action: #selector(selectFriendsButton(_:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let contactsButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "联系人"), for: .normal)
        button.addTarget(self, action: #selector(selectContactsButton(_:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let activityParticipatedInButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "我参与的"), for: .normal)
        button.addTarget(self, action: #selector(selectActivitiesParticipatedIn(_:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let activityReleasedButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "我发布的"), for: .normal)
        button.addTarget(self, action: #selector(selectActivitiesReleased(_:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tarStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: CGPoint(x: 8, y: 8), size: CGSize(width: 24, height: 24))
        button.setImage(#imageLiteral(resourceName: "settings-icon"), for: .normal)
        return button
    }()
    
    let tableView = UITableView()
    
    func selectActivitiesParticipatedIn(_ sender: UIButton) {
        tarBarSelect = 0
    }
    
    func selectActivitiesReleased(_ sender: UIButton) {
        tarBarSelect = 1
    }
    
    func selectFriendsButton(_ sender: UIButton) {
        tarBarSelect = 2
    }
    
    func selectContactsButton(_ sender: UIButton) {
        tarBarSelect = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = UIColor(red:0.91, green:0.93, blue:0.95, alpha:1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0)
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target: nil, action: nil)
        setupSettingsIcon()
        setupBasicInfoView()
        setupTarStackView()
        setupTableView()
        initSampleData()
    }
    
    func setupSettingsIcon() {
        settingsButton.addTarget(self, action: #selector(touchSettings(_:)), for: .touchUpInside)
        let rightBarItem = UIBarButtonItem(customView: settingsButton)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setupBasicInfoView() {
        view.addSubview(basicInfoContainerView)
        basicInfoContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        basicInfoContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        basicInfoContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        basicInfoContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.36).isActive = true
        
        basicInfoContainerView.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: basicInfoContainerView.topAnchor, constant: 0).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: basicInfoContainerView.leftAnchor, constant: 0).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: basicInfoContainerView.rightAnchor, constant: 0).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: basicInfoContainerView.bottomAnchor, constant: 0).isActive = true
        
        basicInfoContainerView.addSubview(portraitImageView)
        portraitImageView.centerXAnchor.constraint(equalTo: basicInfoContainerView.centerXAnchor).isActive = true
        portraitImageView.widthAnchor.constraint(equalTo: basicInfoContainerView.widthAnchor, multiplier: 0.19).isActive = true
        portraitImageView.heightAnchor.constraint(equalTo: portraitImageView.widthAnchor).isActive = true
        portraitImageView.centerYAnchor.constraint(equalTo: basicInfoContainerView.centerYAnchor, constant: -26).isActive = true
        
        basicInfoContainerView.addSubview(userNameView)
        userNameView.centerXAnchor.constraint(equalTo: basicInfoContainerView.centerXAnchor, constant: 0).isActive = true
        userNameView.widthAnchor.constraint(equalTo: portraitImageView.widthAnchor, multiplier: 2).isActive = true
        userNameView.heightAnchor.constraint(equalTo: portraitImageView.heightAnchor, multiplier: 0.4).isActive = true
        userNameView.topAnchor.constraint(equalTo: portraitImageView.bottomAnchor, constant: 10).isActive = true
        
        basicInfoContainerView.addSubview(signature)
        signature.centerXAnchor.constraint(equalTo: basicInfoContainerView.centerXAnchor, constant: 0).isActive = true
        signature.topAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: 10).isActive = true
        signature.widthAnchor.constraint(equalTo: portraitImageView.widthAnchor, multiplier: 3).isActive = true
        signature.heightAnchor.constraint(equalTo: userNameView.heightAnchor, multiplier: 1).isActive = true
    }
    
    func setupTarStackView() {
        let activityIParticipatedInView = UIView()
        let activityIReleasedView = UIView()
        let friendsView = UIView()
        let contactsView = UIView()
        
        tarStackView.addArrangedSubview(activityIReleasedView)
        tarStackView.addArrangedSubview(activityIParticipatedInView)
        tarStackView.addArrangedSubview(friendsView)
        tarStackView.addArrangedSubview(contactsView)
        tarStackView.axis = .horizontal
        tarStackView.distribution = .fillEqually
        tarStackView.translatesAutoresizingMaskIntoConstraints = false
        activityIParticipatedInView.backgroundColor = .white
        activityIParticipatedInView.translatesAutoresizingMaskIntoConstraints = false
        activityIReleasedView.backgroundColor = .white
        activityIReleasedView.translatesAutoresizingMaskIntoConstraints = false
        friendsView.backgroundColor = .white
        friendsView.translatesAutoresizingMaskIntoConstraints = false
        contactsView.backgroundColor = .white
        contactsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tarStackView)
        tarStackView.topAnchor.constraint(equalTo: basicInfoContainerView.bottomAnchor, constant: 4).isActive = true
        tarStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tarStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tarStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
        view.addSubview(activityParticipatedInButton)
        activityParticipatedInButton.centerXAnchor.constraint(equalTo: activityIParticipatedInView.centerXAnchor, constant: 0).isActive = true
        activityParticipatedInButton.centerYAnchor.constraint(equalTo: activityIParticipatedInView.centerYAnchor, constant: 0).isActive = true
        activityParticipatedInButton.widthAnchor.constraint(equalTo: activityIParticipatedInView.widthAnchor, multiplier: 0.9).isActive = true
        activityParticipatedInButton.heightAnchor.constraint(equalTo: activityIParticipatedInView.heightAnchor, multiplier: 0.6).isActive = true
        
        view.addSubview(activityReleasedButton)
        activityReleasedButton.centerXAnchor.constraint(equalTo: activityIReleasedView.centerXAnchor, constant: 0).isActive = true
        activityReleasedButton.centerYAnchor.constraint(equalTo: activityIReleasedView.centerYAnchor, constant: 0).isActive = true
        activityReleasedButton.widthAnchor.constraint(equalTo: activityIReleasedView.widthAnchor, multiplier: 0.9).isActive = true
        activityReleasedButton.heightAnchor.constraint(equalTo: activityIReleasedView.heightAnchor, multiplier: 0.6).isActive = true
        
        view.addSubview(contactsButton)
        contactsButton.centerXAnchor.constraint(equalTo: contactsView
            .centerXAnchor, constant: 0).isActive = true
        contactsButton.centerYAnchor.constraint(equalTo: contactsView.centerYAnchor, constant: 0).isActive = true
        contactsButton.widthAnchor.constraint(equalTo: contactsView.widthAnchor, multiplier: 0.9).isActive = true
        contactsButton.heightAnchor.constraint(equalTo: contactsView.heightAnchor, multiplier: 0.6).isActive = true
        
        view.addSubview(friendsButton)
        friendsButton.centerXAnchor.constraint(equalTo: friendsView.centerXAnchor, constant: 0).isActive = true
        friendsButton.centerYAnchor.constraint(equalTo: friendsView.centerYAnchor, constant: 0).isActive = true
        friendsButton.widthAnchor.constraint(equalTo: friendsView.widthAnchor, multiplier: 0.9).isActive = true
        friendsButton.heightAnchor.constraint(equalTo: friendsView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OwnActivityCell.self, forCellReuseIdentifier: CloserUtility.OwnActivityCellReuseId)
        tableView.register(ActivityCell.self, forCellReuseIdentifier: CloserUtility.ActivityCellReuseId)
        tableView.register(OtherUserTableViewCell.self, forCellReuseIdentifier: OtherUserTableViewCell.cellReuseId)
        tableView.topAnchor.constraint(equalTo: tarStackView.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    var activitiesParticipatedIn = [Activity]() {
        didSet {
            tableView.reloadData()
        }
    }
    var activitiesReleased = [Activity]() {
        didSet {
            tableView.reloadData()
        }
    }
    var friends = [User]()
    var contacts = [User]()
    
    func touchSettings(_ sender: UIButton) {
        self.navigationController?.pushViewController(SettingsController(), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tarBarSelect {
        case 0:
            return activitiesParticipatedIn.count
        case 1:
            return activitiesReleased.count
        case 2:
            return friends.count
        case 3:
            return contacts.count
        default:
            return activitiesParticipatedIn.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch tarBarSelect {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: CloserUtility.ActivityCellReuseId, for: indexPath)
            let activity = activitiesParticipatedIn[indexPath.row]
            if let activityCell = cell as? ActivityCell {
                activityCell.activity = activity
            }
//            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: CloserUtility.OwnActivityCellReuseId, for: indexPath)
            let activity = activitiesReleased[indexPath.row]
            if let activityCell = cell as? OwnActivityCell {
                activityCell.activity = activity
            }
//            break
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: OtherUserTableViewCell.cellReuseId, for: indexPath)
            let friend = friends[indexPath.row]
            if let userCell = cell as? OtherUserTableViewCell {
                userCell.user = friend
            }
            break
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: OtherUserTableViewCell.cellReuseId, for: indexPath)
            let contact = contacts[indexPath.row]
            if let userCell = cell as? OtherUserTableViewCell {
                userCell.user = contact
            }
            break
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: CloserUtility.ActivityCellReuseId, for: indexPath)
            let activity = activitiesParticipatedIn[indexPath.row]
            if let activityCell = cell as? ActivityCell {
                activityCell.activity = activity
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tarBarSelect {
        case 0:
            let currAcvitity = activitiesParticipatedIn[indexPath.row]
            
            if let act = currAcvitity as? GeneralActivity{
                let size = CGSize(width: tableView.bounds.width - 90, height: 1000)
                
                let estimatedUserNameFrame = NSString(string: act.userReleasing.userName).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)], context: nil)
                
                let estimatedActivityNameFrame = NSString(string: act.name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)], context: nil)
                
                let estimatedActivityDescriptionFrame = NSString(string: (act.description.first?.content)!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)], context: nil)
                
                let estimatedActivityDescriptionFrameHeight = min(130, estimatedActivityDescriptionFrame.height + 10)
                
                let estimatedHeight = max(80, estimatedUserNameFrame.height + estimatedActivityNameFrame.height + estimatedActivityDescriptionFrameHeight)
                
                return estimatedHeight
            }
        case 1:
            let currAcvitity = activitiesReleased[indexPath.row]
            
            if let act = currAcvitity as? GeneralActivity{
                let size = CGSize(width: tableView.bounds.width - 90, height: 1000)
                
                let estimatedUserNameFrame = NSString(string: act.userReleasing.userName).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)], context: nil)
                
                let estimatedActivityNameFrame = NSString(string: act.name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)], context: nil)
                
                let estimatedActivityDescriptionFrame = NSString(string: (act.description.first?.content)!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)], context: nil)
                
                let estimatedActivityDescriptionFrameHeight = min(130, estimatedActivityDescriptionFrame.height + 10)
                
                let estimatedHeight = max(80, estimatedUserNameFrame.height + estimatedActivityNameFrame.height + estimatedActivityDescriptionFrameHeight)
                
                return estimatedHeight
            }
        case 2, 3:
            return 60
        default:
            break
        }
        
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tarBarSelect {
        case 0:
            let controller = FullActivityReviewViewController()
            controller.activity = activitiesParticipatedIn[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 1:
            let controller = FullActivityReviewViewController()
            controller.activity = activitiesReleased[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 2:
            let controller = OtherUserHomePageController()
            controller.user = friends[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            break
        case 3:
            let controller = OtherUserHomePageController()
            controller.user = contacts[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
    }
    
    private func initSampleData() {
        //for sample users
        let user1 = PersonalUserForView(userName: "周逸", userId: "1", gender: Gender.Female, age: 22)
        user1.userProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait4.jpeg?alt=media&token=f18cb3cc-f78e-406d-a305-c35b72040c70"
        user1.backgroundImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground.jpeg?alt=media&token=cbbf9a20-9401-4d4f-a069-7750e2d7f8b6"
        user1.signature = "我是魔王我怕谁"
        let user2 = PersonalUserForView(userName: "丁一", userId: "2", gender: Gender.Female, age: 23)
        user2.userProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait3.jpg?alt=media&token=afc1760d-dcd4-48df-885e-4d3999824fc3"
        user2.backgroundImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground2.jpg?alt=media&token=cd9368de-5ea1-43e0-b783-e05ea3a0c53b"
        user2.signature = "全世界我最萌"
        let user3 = PersonalUserForView(userName: "Peter", userId: "3", gender: Gender.Male, age: 23)
        user3.userProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait1.jpeg?alt=media&token=81737b88-20a3-4ac2-b3e3-ec55ac1c7b41"
        user3.backgroundImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground.jpeg?alt=media&token=cbbf9a20-9401-4d4f-a069-7750e2d7f8b6"
        user3.signature = "我是创业达人"
        friends.append(user1)
        friends.append(user2)
        friends.append(user3)
        
        let user4 = PersonalUserForView(userName: "丁磊", userId: "4", gender: Gender.Female, age: 22)
        user4.userProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait2.png?alt=media&token=fc65090f-fd7a-47f3-8a6a-bb4def659c32"
        user4.backgroundImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground2.jpg?alt=media&token=cd9368de-5ea1-43e0-b783-e05ea3a0c53b"
        user4.signature = "我的艺术细胞有限，但是很自恋"
        let user5 = PersonalUserForView(userName: "Zenith", userId: "5", gender: Gender.Female, age: 23)
        user5.userProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait5.jpeg?alt=media&token=e55f0d45-431a-491d-b34f-74ec78aa2753"
        user5.backgroundImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground.jpeg?alt=media&token=cbbf9a20-9401-4d4f-a069-7750e2d7f8b6"
        user5.signature = "我是一个有思想的产品经理"
        let user6 = PersonalUserForView(userName: "王凯铭", userId: "6", gender: Gender.Male, age: 23)
        user6.userProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/sampleHeaderPortrait6.jpeg?alt=media&token=6b484d7f-103c-4e6d-b95b-33b3f15df705"
        user6.backgroundImageUrl = "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground2.jpg?alt=media&token=cd9368de-5ea1-43e0-b783-e05ea3a0c53b"
        user6.signature = "我是一个闷骚而优秀的男人"
        contacts.append(user4)
        contacts.append(user5)
        contacts.append(user6)
        contacts.append(user1)
        contacts.append(user2)
        
        let description: [DescriptionUnit]
        let description1 = DescriptionUnit(type: ContentType.Text.rawValue, content: "真是太兴奋了，真的是掩饰不了自己的期待，Closer就快要上线了！")
        let description2 = DescriptionUnit(type: ContentType.Image.rawValue, content: "https://pic3.zhimg.com/v2-897dde8d58d235a211c3774f3a7648ea_b.png")
        let description3 = DescriptionUnit(type: ContentType.Hyperlink.rawValue, content: "Amazon::::::https://www.amazon.com/")
        description = [description1, description2, description3]
        let activity1 = GeneralActivity(name: "去改变世界吧", tags: ["热情", "活力"], authority: Authority.Public, description: description, userReleasing: user1, identity: "7feuf289f89s89f8f")
        activity1.timeStart = Date()
        activity1.timeEnd = Date(timeIntervalSinceNow: 10*60)
        activity1.location = CLLocation(latitude: 37, longitude: 122)
        
        let descriptiont: [DescriptionUnit]
        let description4 = DescriptionUnit(type: ContentType.Text.rawValue, content: "让我们加入明天的Closer的活动吧，我认为这太兴奋了。任何人如果想加入，不要犹豫，我们欢迎你！具体的活动内容如下：\n1.跟大神王凯铭学长讨论学（duan）术（zi）问题。2.跟Closer创始团队讨论创业经历")
        let description5 = DescriptionUnit(type: ContentType.Image.rawValue, content: "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground2.jpg?alt=media&token=cd9368de-5ea1-43e0-b783-e05ea3a0c53b")
        let description6 = DescriptionUnit(type: ContentType.Hyperlink.rawValue, content: "上海交通大学::::::http://vol.sjtu.edu.cn/newalpha/")
        descriptiont = [description4, description5, description6]
        let activity2 = GeneralActivity(name: "去看看上海交大吧！", tags: ["Closer", "活动"], authority: Authority.Public, description: descriptiont, userReleasing: user2, identity: "fjaioef2308f90w2")
        activity2.timeStart = Date()
        activity2.timeEnd = Date(timeIntervalSinceNow: 10*60)
        activity2.location = CLLocation(latitude: 37, longitude: 122)
        
        let descriptiontt: [DescriptionUnit]
        let description7 = DescriptionUnit(type: ContentType.Text.rawValue, content: "明天有谁想一起来吃饭的？新开的新疆餐厅很不错，就在拖鞋门口，时间是晚上6点半，地点在拖鞋门口直走左拐100米处，欢迎大家一起来参加啊~")
        let description8 = DescriptionUnit(type: ContentType.Image.rawValue, content: "https://firebasestorage.googleapis.com/v0/b/closer-17ee2.appspot.com/o/mybackground2.jpg?alt=media&token=cd9368de-5ea1-43e0-b783-e05ea3a0c53b")
        let description9 = DescriptionUnit(type: ContentType.Hyperlink.rawValue, content: "上海交通大学::::::http://vol.sjtu.edu.cn/newalpha/")
        descriptiontt = [description7, description8, description9]
        let activity3 = GeneralActivity(name: "聚餐，一起来尝尝新开的新疆餐厅吧！", tags: ["聚餐", "活动"], authority: Authority.Public, description: descriptiontt, userReleasing: user3, identity: "fjaioef2308f90w2")
        activity3.timeStart = Date()
        activity3.timeEnd = Date(timeIntervalSinceNow: 10*60)
        activity3.location = CLLocation(latitude: 37, longitude: 122)
        activitiesParticipatedIn.append(activity1)
        activitiesParticipatedIn.append(activity2)
        activitiesReleased.append(activity2)
        activitiesReleased.append(activity1)
        activitiesParticipatedIn.append(activity3)
        activitiesReleased.append(activity3)

    }
}
