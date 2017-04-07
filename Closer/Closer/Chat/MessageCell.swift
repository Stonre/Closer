//
//  MessageCell.swift
//  Closer
//
//  Created by z on 2017/2/11.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    /*var message: Message? {
        didSet {
            self.messageText.text = self.message?.text
            let type = (self.message?.type)!
            switch type {
            case "group":
                setupGroupNameAndImage()
                setupChatTime()
            default:
                setupNameAndImage()
                setupChatTime()
            }
            
        }
    }*/
    
    var messageText: UILabel = {
        var textView = UILabel()
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.numberOfLines = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    static let lightBlueColor = UIColor(r: 176, g: 224, b: 230)
    static let lightGrayColor = UIColor(r: 240, g: 240, b: 240)
    
    var textBubble: UIView = {
        var bubble = UIView()
        bubble.backgroundColor = lightBlueColor
        bubble.layer.cornerRadius = 15
        bubble.layer.masksToBounds = true
        bubble.translatesAutoresizingMaskIntoConstraints = false
        return bubble
    }()
    
    var senderImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "sampleHeaderPortrait2")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var senderName: UILabel = {
        var nameText = UILabel()
        nameText.backgroundColor = UIColor.clear
        nameText.font = UIFont.systemFont(ofSize: 10)
        nameText.numberOfLines = 1
        nameText.translatesAutoresizingMaskIntoConstraints = false
        return nameText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textBubble)
        self.addSubview(senderImage)
        self.addSubview(senderName)
        textBubble.addSubview(messageText)
        setupTextBubble()
        setupMessageText()
        setupSenderName()
        setupSenderImage()
    }
    
    func setupSenderName() {
        senderName.leftAnchor.constraint(equalTo: senderImage.rightAnchor, constant: 8).isActive = true
        senderName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //senderName.heightAnchor.constraint
    }
    
    var imageLeftAnchor: NSLayoutConstraint?
    var imageRightAnchor: NSLayoutConstraint?
    
    func setupSenderImage() {
        imageLeftAnchor = senderImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        imageLeftAnchor?.isActive = true
        imageRightAnchor = senderImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        imageRightAnchor?.isActive = false
        senderImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        senderImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        senderImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupMessageText() {
        messageText.leftAnchor.constraint(equalTo: textBubble.leftAnchor, constant: 8).isActive = true
        messageText.topAnchor.constraint(equalTo: textBubble.topAnchor).isActive = true
        messageText.rightAnchor.constraint(equalTo: textBubble.rightAnchor, constant: -8).isActive = true
        messageText.heightAnchor.constraint(equalTo: textBubble.heightAnchor).isActive = true
    }
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleLeftAnchor: NSLayoutConstraint?
    var bubbleRightAnchor: NSLayoutConstraint?
    var bubbleTopAnchorForSelf: NSLayoutConstraint?
    var bubbleTopAnchorForOthers: NSLayoutConstraint?
    var bubbleHeightForOthers: NSLayoutConstraint?
    var bubbleHeightForSelf: NSLayoutConstraint?
    
    func setupTextBubble() {
        bubbleRightAnchor = textBubble.rightAnchor.constraint(equalTo: senderImage.leftAnchor, constant: -8)
        bubbleRightAnchor?.isActive = true
        bubbleLeftAnchor = textBubble.leftAnchor.constraint(equalTo: senderImage.rightAnchor, constant: 8)
        bubbleLeftAnchor?.isActive = false
        bubbleTopAnchorForOthers = textBubble.topAnchor.constraint(equalTo: senderName.bottomAnchor, constant: 4)
        bubbleTopAnchorForOthers?.isActive = true
        bubbleTopAnchorForSelf = textBubble.topAnchor.constraint(equalTo: self.topAnchor)
        bubbleTopAnchorForSelf?.isActive = false
        bubbleWidthAnchor = textBubble.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleHeightForSelf = textBubble.heightAnchor.constraint(equalTo: self.heightAnchor)
        bubbleHeightForSelf?.isActive = false
        bubbleHeightForOthers = textBubble.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -15)
        bubbleHeightForOthers?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
