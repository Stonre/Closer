//
//  OtherUserTableViewCell.swift
//  Closer
//
//  Created by Lei Ding on 1/12/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit

class OtherUserTableViewCell: UITableViewCell {
    
    static let cellReuseId = "OtherUserTableCell"
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var user: User? {
        didSet {
            updateUI()
        }
    }
    
    var activity: ActivityChatProfile? {
        didSet {
            updateActivityUI()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        profileImageView.image = nil
        userName.text = nil
        if let user = self.user {
            if let profileImageUrlString = user.userProfileImageUrl {
                setupProfileImage(imageUrl: profileImageUrlString)
            }
            userName.text = user.userName
        }
    }
    
    func updateActivityUI() {
        profileImageView.image = nil
        userName.text = nil
        if let activity = self.activity {
            /*if let profileImageUrlString = activity.userReleasing.userProfileImageUrl {
                setupProfileImage(imageUrl: profileImageUrlString)
            }*/
            userName.text = activity.activityName
        }
    }
    
    func setupProfileImage(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data!)
                }
                
            }).resume()
        }
    }
    
    func setUpView() {
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        addSubview(userName)
        userName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userName.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        userName.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20).isActive = true
        userName.rightAnchor.constraint(equalTo: rightAnchor, constant: 12).isActive = true
    }

}
