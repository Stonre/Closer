//
//  HomePageController.swift
//  Closer
//
//  Created by Lei Ding on 2/2/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit

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
        tableView.delegate = self
        tableView.dataSource = self
        setupBasicInfoView()
        setupTarStackView()
        setupTableView()
        initSampleData()
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
        tableView.register(OwnActivityCell.self, forCellReuseIdentifier: OwnActivityCell.cellReuseID)
        tableView.register(ActivityCell.self, forCellReuseIdentifier: ActivityCell.cellReuseID)
        tableView.register(OtherUserTableViewCell.self, forCellReuseIdentifier: OtherUserTableViewCell.cellReuseId)
        tableView.topAnchor.constraint(equalTo: tarStackView.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    var activitiesParticipatedIn = [Activity]()
    var activitiesReleased = [Activity]()
    var friends = [User]()
    var contacts = [User]()
    
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
            cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.cellReuseID, for: indexPath)
            let activity = activitiesParticipatedIn[indexPath.row]
            if let activityCell = cell as? ActivityCell {
                activityCell.activity = activity
            }
            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: OwnActivityCell.cellReuseID, for: indexPath)
            let activity = activitiesReleased[indexPath.row]
            if let activityCell = cell as? OwnActivityCell {
                activityCell.activity = activity
            }
            break
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
            cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.cellReuseID, for: indexPath)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tarBarSelect {
        case 0:
            let currAcvitity = activitiesParticipatedIn[indexPath.row]
            
            if let act = currAcvitity as? GeneralActivity{
                let size = CGSize(width: tableView.bounds.width - 90, height: 1000)
                
                let estimatedUserNameFrame = NSString(string: act.userReleasing.userName).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)], context: nil)
                
                let estimatedActivityNameFrame = NSString(string: act.name).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)], context: nil)
                
                let estimatedActivityDescriptionFrame = NSString(string: act.description.text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)], context: nil)
                
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
                
                let estimatedActivityDescriptionFrame = NSString(string: act.description.text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)], context: nil)
                
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch tarBarSelect {
        case 0:
            break
        case 1:
            break
        case 2:
            let controller = OtherUserHomePageController()
            navigationController?.pushViewController(controller, animated: true)
            break
        case 3:
            let controller = OtherUserHomePageController()
            navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
    }
    
    private func initSampleData() {
        //for sample users
        let user1 = PersonalUserForView(userName: "Yi Zhou", userId: "1", gender: Gender.Female, age: 22)
        user1.headPortrait = UIImagePNGRepresentation(#imageLiteral(resourceName: "sampleHeaderPortrait4")) as NSData?
        let user2 = PersonalUserForView(userName: "Yi Ding", userId: "2", gender: Gender.Female, age: 23)
        user2.headPortrait = UIImagePNGRepresentation(#imageLiteral(resourceName: "sampleHeaderPortrait3")) as NSData?
        let user3 = PersonalUserForView(userName: "Peter", userId: "3", gender: Gender.Male, age: 23)
        user3.headPortrait = UIImagePNGRepresentation(#imageLiteral(resourceName: "sampleHeaderPortrait1")) as NSData?
        friends.append(user1)
        friends.append(user2)
        friends.append(user3)
        
        let user4 = PersonalUserForView(userName: "Lei Ding", userId: "4", gender: Gender.Female, age: 22)
        user4.headPortrait = UIImagePNGRepresentation(#imageLiteral(resourceName: "sampleHeaderPortrait2")) as NSData?
        let user5 = PersonalUserForView(userName: "Zenith", userId: "5", gender: Gender.Female, age: 23)
        user5.headPortrait = UIImagePNGRepresentation(#imageLiteral(resourceName: "sampleHeaderPortrait5")) as NSData?
        let user6 = PersonalUserForView(userName: "Kaimi", userId: "6", gender: Gender.Male, age: 23)
        user6.headPortrait = UIImagePNGRepresentation(#imageLiteral(resourceName: "sampleHeaderPortrait6")) as NSData?
        contacts.append(user4)
        contacts.append(user5)
        contacts.append(user6)
        contacts.append(user1)
        contacts.append(user2)
    }
}
