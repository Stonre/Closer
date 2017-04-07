//
//  Extensions.swift
//  Closer
//
//  Created by z on 2017/4/6.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

func setGroupImageProfile(participants: [[String: String]], numOfParticipants: Int, profileImageView: UIImageView) {
    var imageViews = [UIImageView]()
    for index in 0 ... (min(numOfParticipants, 4) - 1) {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViews.append(imageView)
        setupProfileImage(imageUrl: participants[index]["profileImageUrl"]!, imageView: imageViews[index])
        profileImageView.addSubview(imageViews[index])
        
        imageViews[index].widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageViews[index].heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    if numOfParticipants == 2 {
        imageViews[0].leftAnchor.constraint(equalTo: profileImageView.leftAnchor).isActive = true
        imageViews[0].centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        imageViews[1].rightAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        imageViews[1].centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
    }
    
    if numOfParticipants == 3 {
        imageViews[0].centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        imageViews[0].topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        imageViews[1].leftAnchor.constraint(equalTo: profileImageView.leftAnchor).isActive = true
        imageViews[1].bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        imageViews[2].rightAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        imageViews[2].bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
    }
    
    if numOfParticipants >= 4 {
        imageViews[0].leftAnchor.constraint(equalTo: profileImageView.leftAnchor).isActive = true
        imageViews[0].topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        imageViews[1].rightAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        imageViews[1].topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        imageViews[2].leftAnchor.constraint(equalTo: profileImageView.leftAnchor).isActive = true
        imageViews[2].bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        imageViews[3].rightAnchor.constraint(equalTo: profileImageView.rightAnchor).isActive = true
        imageViews[3].bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
    }
}

func setupProfileImage(imageUrl: String, imageView: UIImageView) {
    if let url = URL(string: imageUrl) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
            }
            
        }).resume()
    }
}
