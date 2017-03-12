//
//  ChatCell.swift
//  Closer
//
//  Created by z on 2017/2/3.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

class ChatCell: UITableViewCell {
    
    var message: Message? {
        didSet {
            
            setupNameAndImage()
            self.detailTextLabel?.text = self.message?.text
            setupChatTime()

        }
    }
    
    private func setupNameAndImage() {
        
        if let partnerId = message?.chatPartnerId() {
            let ref = FIRDatabase.database().reference().child("users").child(partnerId)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: Any] {
                    self.textLabel?.text = dictionary["name"] as? String
                    if let imageUrl = dictionary["profileImageUrl"] as? String {
                        self.setupProfileImage(imageUrl: imageUrl)
                    }
                }
                
            }, withCancel: nil)
        }
    }
    
    private func setupChatTime() {
        if let seconds = message?.time?.doubleValue {
            let timestampDate = Date(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            chatTimeLabel.text = dateFormatter.string(from: timestampDate)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 66, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 66, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sampleHeaderPortrait2")
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let chatTimeLabel: UILabel = {
        let timeView = UILabel()
        timeView.textColor = UIColor.darkGray
        timeView.font = UIFont.systemFont(ofSize: 12)
        timeView.text = "time"
        timeView.translatesAutoresizingMaskIntoConstraints = false
        return timeView
    }()
    
    private func setupProfileImage(imageUrl: String) {
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
    
    var personalChat: PersonalChat? {
        didSet {
            updatePersonalChatUI()
        }
    }
    
    var eventChat: ActivityChatProfile? {
        didSet {
            updateEventChatUI()
        }
    }
    
    private func updatePersonalChatUI() {
        chatTimeLabel.text = personalChat?.lastContactTime
        detailTextLabel?.text = personalChat?.lastMessage
        textLabel?.text = personalChat?.person.displayName
        if let profileImageUrl = personalChat?.person.userProfileImage {
            setupProfileImage(imageUrl: profileImageUrl)
        }
    }
    
    private func updateEventChatUI() {
        //chatTimeLabel.text = eventChat?.lastContactTime
        //detailTextLabel?.text = eventChat?.lastMessage
        textLabel?.text = eventChat?.activityName
        //profileImageView.image = UIImage(data:eventChat?.groupImage as! Data,scale:1.0)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.addSubview(profileImageView)
        self.addSubview(chatTimeLabel)
        
        setupProfileImageView()
        setupChatTimeLabel()
    }
    
    func setupProfileImageView() {
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupChatTimeLabel() {
        chatTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        chatTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        chatTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        chatTimeLabel.heightAnchor.constraint(equalToConstant: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
