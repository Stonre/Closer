//
//  ChatLogViewController.swift
//  Closer
//
//  Created by z on 2017/2/3.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class ChatLogViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var messages = [Message]()
    
    var containerHeightAnchor: NSLayoutConstraint?
    
    var personalUser: PersonalUserForView? {
        didSet {
            self.navigationItem.title = personalUser?.userName
            observeMessages()
        }
    }
    
    var eventChat: ActivityChatProfile? {
        didSet {
            self.navigationItem.title = eventChat?.activityName
        }
    }
    
    func observeMessages() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        
        let userMessageRef = FIRDatabase.database().reference().child("user-messages").child(uid)
        userMessageRef.observe(.childAdded, with: { (snapshot) in
            
            let messageKey = snapshot.key
            
            let messageRef = FIRDatabase.database().reference().child("messages").child(messageKey)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else {
                    return
                }
                let message = Message()
                message.setValuesForKeys(dictionary)
                if message.chatPartnerId() == self.personalUser?.userId {
                    self.messages.append(message)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                        let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }, withCancel: nil)
            
        }, withCancel: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.contentInset = UIEdgeInsetsMake(8, 0, 8, 0)
        //self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.alwaysBounceVertical = true
        
        self.collectionView?.keyboardDismissMode = .interactive
        //setupInputComponents()
        setupKeyboardObservers()
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: .UIKeyboardDidShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func handleKeyboardDidShow(notification: Notification) {
        if messages.count > 0 {
            let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    /*func handleKeyboardWillShow(notification: Notification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
     
        if let height = keyboardFrame?.height {
            containerViewBottomAnchor?.constant = -height
            UIView.animate(withDuration: keyboardDuration!, animations: {
                self.view.layoutIfNeeded()
            })
        }
     }
     
     func handleKeyboardWillHide(notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
     
        containerViewBottomAnchor?.constant = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }*/
    
    lazy var inputContainerView: UIView = {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        containerView.backgroundColor = UIColor(r: 235, g: 235, b: 235)
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("发送", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        let seperatorLineView = UIView()
        seperatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(self.inputTextField)
        containerView.addSubview(seperatorLineView)
        containerView.addSubview(sendButton)
        
        seperatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8).isActive = true
        
        return containerView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true;
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(r: 280, g: 280, b: 280)
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func handleSend() {
        let messageRef = FIRDatabase.database().reference().child("messages").childByAutoId()
        let toId = personalUser!.userId
        let fromId = FIRAuth.auth()!.currentUser!.uid
        let timeStamp = Date().timeIntervalSince1970
        let values = ["text": inputTextField.text!, "to": toId, "from": fromId, "time": timeStamp] as [String : Any]
        messageRef.updateChildValues(values) { (error, reference) in
            if error != nil {
                print(error!)
                return
            }
            
            let messageId = messageRef.key
            let senderMessagesRef = FIRDatabase.database().reference().child("user-messages").child(fromId)
            senderMessagesRef.updateChildValues([messageId: 1])
            
            let receiverMessagesRef = FIRDatabase.database().reference().child("user-messages").child(toId)
            receiverMessagesRef.updateChildValues([messageId: 1])
        }
        self.inputTextField.text = nil
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text: text).height + 20
        }
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 10000000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        let message = messages[indexPath.item]
        guard let messageText = message.text else {
            return cell
        }
        cell.messageText.text = messageText
        setupCell(cell: cell, message: message)
        
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: messageText).width + 20
        
        return cell
    }
    
    private func setupCell(cell: MessageCell, message: Message) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        if message.from == uid {
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
            cell.textBubble.backgroundColor = MessageCell.lightBlueColor
        } else {
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
            cell.textBubble.backgroundColor = MessageCell.lightGrayColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }

}
