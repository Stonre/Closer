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
    
    let userHeaderPortrait: UIImageView = {
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
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        userHeaderPortrait.image = nil
        userName.text = nil
        if let user = self.user {
            userHeaderPortrait.image = UIImage(data: user.headPortrait as! Data)
            userName.text = user.userName
        }
    }
    
    func setUpView() {
        addSubview(userHeaderPortrait)
        userHeaderPortrait.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userHeaderPortrait.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        userHeaderPortrait.widthAnchor.constraint(equalToConstant: 45).isActive = true
        userHeaderPortrait.heightAnchor.constraint(equalToConstant: 45).isActive = true
        addSubview(userName)
        userName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userName.heightAnchor.constraint(equalTo: userHeaderPortrait.heightAnchor).isActive = true
        userName.leftAnchor.constraint(equalTo: userHeaderPortrait.rightAnchor, constant: 20).isActive = true
        userName.rightAnchor.constraint(equalTo: rightAnchor, constant: 12).isActive = true
    }

}
