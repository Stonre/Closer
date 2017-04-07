//
//  NewActivityDescriptionViewController.swift
//  Closer
//
//  Created by Kami on 2017/2/20.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit
import Firebase

class NewActivityDescriptionViewController: NewActivityContentViewController {
    
    let titleLabel = UILabel()
    let descriptionView = UITextView()
    var containerView = UIView()
    var addImageButton = UIButton()
    var addUserReference = UIButton()
    
    let imagePicker = UIImagePickerController()
    var descriptionViewBottomAnchor: NSLayoutConstraint?
    var formattedDescription = [DescriptionUnit]()
    
    let uploadGroup = DispatchGroup()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NewActivityController.bgColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(quitEditing)))

        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: .main) { (notification) in
            self.containerView.frame.origin.y = self.view.bounds.maxY - 36
            self.descriptionView.contentInset.bottom = 0
            
            self.descriptionViewBottomAnchor?.isActive = false
            self.descriptionViewBottomAnchor = self.descriptionView.bottomAnchor.constraint(equalTo: self.containerView.topAnchor, constant: -8)
            self.descriptionViewBottomAnchor?.isActive = true
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: .main) { (notification) in
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.containerView.frame.origin.y = self.view.bounds.maxY - keyboardSize.height
                
                self.descriptionViewBottomAnchor?.isActive = false
                self.descriptionViewBottomAnchor = self.descriptionView.bottomAnchor.constraint(equalTo: self.containerView.topAnchor, constant: -8)
                self.descriptionViewBottomAnchor?.isActive = true
            }

        }
        
        contentIndex = 3
        setupTitleLabel()
        setupContainerView()
        setupDescriptionView()
        setupImagePickerController()
//        descriptionView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = NewActivityController.bgColorTransparent
        titleLabel.text = "任务描述："
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    private func setupDescriptionView() {
        view.addSubview(descriptionView)
        descriptionView.backgroundColor = NewActivityController.bgColorTransparent
        descriptionView.delegate = self
        descriptionView.isEditable = true
        descriptionView.font = UIFont.preferredFont(forTextStyle: .body)
//        descriptionView.becomeFirstResponder()
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        descriptionView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        descriptionViewBottomAnchor = descriptionView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -8)
        descriptionViewBottomAnchor?.isActive = true
        //descriptionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func setupContainerView() {
        view.addSubview(containerView)
//        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = NewActivityController.bgColorTransparent
        containerView.frame = CGRect(x: view.bounds.minX, y: view.bounds.maxY - 76, width: view.bounds.width, height: 36)
        
        
        containerView.addSubview(addImageButton)
        addImageButton.frame = CGRect(x: containerView.bounds.maxX - 48, y: containerView.bounds.minY + 4, width: 36, height: 30)
        addImageButton.setImage(#imageLiteral(resourceName: "add-image-icon"), for: .normal)
        addImageButton.clipsToBounds = true
        addImageButton.addTarget(self, action: #selector(touchAddImageButton), for: .touchUpInside)
        
        //addUserReference = UIButton(type: .system)
        containerView.addSubview(addUserReference)
        addUserReference.frame = CGRect(x: containerView.bounds.maxX - 64, y: containerView.bounds.minY + 4, width: 24, height: 24)
        addUserReference.setTitle("@", for: .normal)
        
    }
    
    func touchAddImageButton() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setupImagePickerController() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
    }
    
    func quitEditing() {
        descriptionView.endEditing(true)
    }
    
    func getDescription() -> NSAttributedString {
        return descriptionView.attributedText
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}

extension NewActivityDescriptionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let scaleFactor: CGFloat = pickedImage.size.width / (descriptionView.frame.size.width - 20)
            let scaledImage = UIImage(cgImage: pickedImage.cgImage!, scale: scaleFactor, orientation: .up)
            let attributedString = NSMutableAttributedString(attributedString: descriptionView.attributedText)
            let textAttachment = NSTextAttachment()
            textAttachment.image = scaledImage
            let attributedStringWithImage = NSAttributedString(attachment: textAttachment)
            let cursorPosition = descriptionView.selectedRange
            let newLine: NSAttributedString = NSAttributedString(string: "\n", attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)])
            attributedString.insert(newLine, at: cursorPosition.location)
            attributedString.insert(attributedStringWithImage, at: cursorPosition.location)
//            let font = UIFont.preferredFont(forTextStyle: .body)
//            attributedString.enumerateAttribute(NSFontAttributeName, in: NSMakeRange(0, attributedString.length), options: [], using: { (value, range, pointer) in
//                if range.length < attributedString.length {
////                  attributedString.removeAttribute(NSFontAttributeName, range: range)
//                    attributedString.addAttribute(NSFontAttributeName, value: [font], range: range)
//                }
//            })
            descriptionView.attributedText = attributedString
            
            //descriptionView.font = UIFont.preferredFont(forTextStyle: .body)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
