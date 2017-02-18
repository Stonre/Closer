//
//  ActivityCell.swift
//  Closer
//
//  Created by Kami on 2017/1/22.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import Firebase
import UIKit

class ActivityCell: UITableViewCell {
    
    open var activity: Activity? {
        didSet {
            if activity != nil {
                setupViews(userProfileImageViewWidth: 64.0, userNameLabelHeight: nil)
            }
        }
    }
    var userProfileImageUrl: NSURL? {
        didSet {
            DispatchQueue.global(qos: .userInteractive).async {
                if let imageData = NSData(contentsOf: self.userProfileImageUrl as! URL) {
                    DispatchQueue.main.async {
                        self.userProfileImage = UIImage(data: imageData as Data)
                    }
                }
            }
        }
    }
    
    var userProfileImage: UIImage? {
        didSet {
            profileImageView.image = userProfileImage
        }
    }
    
    open let seperatorLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        lineView.isHidden = true
        return lineView
    }()
    
    let profileImageView = UIImageView()
    let userNameLabel = UILabel(frame: .zero)
    let activityNameLabel = UILabel(frame: .zero)
    let activityDescriptionLabel = UILabel(frame: .zero)
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupViews(userProfileImageViewWidth: CGFloat, userNameLabelHeight: CGFloat?){
        if userProfileImageViewWidth > 0.0 {
            DispatchQueue.global(qos: .userInteractive).async(execute: { 
                self.getUserProfileImageUrl()
            })
        }
        addSubview(seperatorLineView)
        backgroundColor = UIColor.white
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.gray
        setupProfileImageView(width: userProfileImageViewWidth)
        setupUserNameLabel(height: userNameLabelHeight)
        setupActivityNameLabel()
        setupActivityDescriptionLabel()
    }
    
    private func getUserProfileImageUrl(){
        if let act = activity as? GeneralActivity {
            let releaser = act.userReleasing.userId
            
            let releaserDbRef = FIRDatabase.database().reference().child("users").child(releaser)
            releaserDbRef.observe(.value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    if let profileImageUrlString = value["profileImageUrl"] as? String{
                        DispatchQueue.main.async(execute: { 
                            self.userProfileImageUrl = NSURL(string: profileImageUrlString)
                        })
                    }
                }
            })
        }
        
//        return releaserProfileImageUrl
    }
    
    private func setupProfileImageView(width: CGFloat) {
        addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        if width > 0 {
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        } else {
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        }
        profileImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        profileImageView.image = nil
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupUserNameLabel(height: CGFloat?) {
        addSubview(userNameLabel)
//        userNameLabel.backgroundColor = .red
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        userNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        if height != nil {
            userNameLabel.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
        if let generalActivity = activity as? GeneralActivity {
            userNameLabel.text = generalActivity.userReleasing.userName
        }
    }
    
    private func setupActivityNameLabel() {
        addSubview(activityNameLabel)
        activityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        activityNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        activityNameLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor, constant: 0).isActive = true
        activityNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 0).isActive = true
        activityNameLabel.rightAnchor.constraint(equalTo: userNameLabel.rightAnchor, constant: 0)
        
        activityNameLabel.numberOfLines = 3
        activityNameLabel.lineBreakMode = .byWordWrapping

        if let generalActivity = activity as? GeneralActivity {
            activityNameLabel.text = generalActivity.name
        }
    }
    
    private func setupActivityDescriptionLabel() {
        addSubview(activityDescriptionLabel)
//        activityDescriptionLabel.preferredMaxLayoutWidth = bounds.width

        activityDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        activityDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        activityDescriptionLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor, constant: 0).isActive = true
        activityDescriptionLabel.topAnchor.constraint(equalTo: activityNameLabel.bottomAnchor, constant: 0).isActive = true
        activityDescriptionLabel.rightAnchor.constraint(equalTo: userNameLabel.rightAnchor, constant: 0).isActive = true
//        activityDescriptionLabel.heightAnchor.constraint(equalToConstant: 200)
        
        activityDescriptionLabel.numberOfLines = 5
        activityDescriptionLabel.lineBreakMode = .byWordWrapping
        
        if let generalActivity = activity as? GeneralActivity {
            activityDescriptionLabel.text = generalActivity.description.first?.content
            
        }
    }
}

