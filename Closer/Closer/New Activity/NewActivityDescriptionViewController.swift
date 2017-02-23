//
//  NewActivityDescriptionViewController.swift
//  Closer
//
//  Created by Kami on 2017/2/20.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class NewActivityDescriptionViewController: NewActivityContentViewController {
    
    let titleLabel = UILabel()
    let descriptionView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(quitEditing)))

        contentIndex = 3
        setupTitleLabel()
        setupDescriptionView()
//        descriptionView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
        titleLabel.text = "任务描述："
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    private func setupDescriptionView() {
        view.addSubview(descriptionView)
        descriptionView.backgroundColor = .white
        descriptionView.delegate = self
        descriptionView.isEditable = true
//        descriptionView.becomeFirstResponder()
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        descriptionView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        descriptionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func quitEditing() {
        descriptionView.endEditing(true)
    }
    
    func getDescription() -> String? {
        return descriptionView.text
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
