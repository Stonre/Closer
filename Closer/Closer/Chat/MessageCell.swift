//
//  MessageCell.swift
//  Closer
//
//  Created by z on 2017/2/11.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textBubble)
        textBubble.addSubview(messageText)
        setupTextBubble()
        setupMessageText()
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
    
    func setupTextBubble() {
        bubbleRightAnchor = textBubble.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleRightAnchor?.isActive = true
        bubbleLeftAnchor = textBubble.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        bubbleLeftAnchor?.isActive = false
        textBubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = textBubble.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        textBubble.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
