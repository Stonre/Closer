//
//  RadioButtonsViewController.swift
//  Closer
//
//  Created by Kami on 2017/2/21.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

@objc
class RadioButtonView: UIButton {
    
    let indicator = UIButton(frame: CGRect(x: 4, y: 4, width: 12, height: 12))
    var optionIndex = 0
    let nameLabel = UILabel()
    let attachedTextField = UITextField()
    var optionName: String?
    var attachedText: String? {
        return attachedTextField.text
    }
    
    func getName() -> String {
        return optionName!
    }
    
    init(_ optionName: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        self.optionName = optionName
//        self.backgroundColor = .red
        setupIndicator()
        setupNameLabel(optionName)
    }

    
    convenience init(_ optionName: String, withTextFieldPlaceholder placeholder: String) {
        self.init(optionName)
        setupTextField(withPlaceholder: placeholder)
    }
    
    
    private func setupIndicator() {
        self.addSubview(indicator)
//        indicator.backgroundColor = .green
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        indicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 24).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 24).isActive = true
        indicator.setImage(#imageLiteral(resourceName: "radio-button-unselected"), for: .normal)
        indicator.setImage(#imageLiteral(resourceName: "radio-button-selected"), for: .selected)
        indicator.imageView?.sizeToFit()
        indicator.isUserInteractionEnabled = false
//        indicator.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
//        indicator.addTarget(RadioButtonsViewController.self, action: #selector(touchButton), for: .touchUpInside)
    }
    
    func touchButton() {
        indicator.isSelected = true
    }

    
    private func setupNameLabel(_ optionName: String) {
        self.addSubview(nameLabel)
//        nameLabel.backgroundColor = .green
        nameLabel.isUserInteractionEnabled = false
        nameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchButton)))
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.text = optionName
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: indicator.centerYAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: indicator.rightAnchor, constant: 8).isActive = true
        
    }
    
    private func setupTextField(withPlaceholder placeholder: String) {
        self.addSubview(attachedTextField)
//        attachedTextField.backgroundColor = .blue
//        attachedTextField.isUserInteractionEnabled = true
        attachedTextField.placeholder = placeholder
        attachedTextField.font = UIFont.preferredFont(forTextStyle: .body)
        attachedTextField.translatesAutoresizingMaskIntoConstraints = false
        attachedTextField.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        attachedTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        attachedTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        attachedTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
    }
    
    func getTextFieldText() -> String? {
        return attachedText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RadioButtonsViewController: UIViewController {
    
    let containerView = UIStackView()
    var containerViewHeight: CGFloat = 0.0
    var containerViewHeightAnchor: NSLayoutConstraint?
    
    var radioButtons = [RadioButtonView]()
    var selectedButton: UIButton?
    var textFields = [String: RadioButtonView]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .yellow
        containerView.isUserInteractionEnabled = true
        containerView.axis = UILayoutConstraintAxis.vertical
        containerView.distribution = UIStackViewDistribution.equalSpacing
        containerView.spacing = 12
        containerView.alignment = UIStackViewAlignment.center
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        containerViewHeightAnchor = containerView.heightAnchor.constraint(equalToConstant: containerViewHeight)
        containerViewHeightAnchor?.isActive = true
    }
    
    public func addOption(optionName: String) {
        let newRadioButton = RadioButtonView(optionName)
        containerViewHeight += 48
        addButton(newRadioButton)
    }
    
    public func addOption(optionName: String, withTextFieldPlaceholder placeholder: String) {
        let newRadioButton = RadioButtonView(optionName, withTextFieldPlaceholder: placeholder)
        textFields[placeholder] = newRadioButton
        containerViewHeight += 96
        addButton(newRadioButton)
    }
    
    private func addButton(_ newRadioButton: RadioButtonView) {
        containerView.addArrangedSubview(newRadioButton)
        newRadioButton.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside)
        newRadioButton.translatesAutoresizingMaskIntoConstraints = false
        newRadioButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        radioButtons.append(newRadioButton)
        newRadioButton.optionIndex = radioButtons.count
    }
    
    func touchButton(_ sender: UIButton) {
        selectedButton = sender
        for btn in radioButtons {
            btn.indicator.isSelected = false
            btn.attachedTextField.isUserInteractionEnabled = false
        }
        if let radioSender = sender as? RadioButtonView {
            radioSender.indicator.isSelected = true
            radioSender.attachedTextField.isUserInteractionEnabled = true
        }
    }
    
    func getSelectedButtonName() -> String? {
        if let sb = selectedButton as? RadioButtonView {
            return sb.getName()
        }
        return nil
    }
    
    func getTextFieldText(byPlaceholder placeholder: String) -> String? {
        return textFields[placeholder]?.getTextFieldText()
    }
}
