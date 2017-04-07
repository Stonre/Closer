//
//  NewActivityNameViewController.swift
//  Closer
//
//  Created by Kami on 2017/2/20.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class NewActivityNameViewController: NewActivityContentViewController  {
    
    let titleLabel = UILabel()
    let nameTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        contentIndex = 0
        view.backgroundColor = NewActivityController.bgColor
        setupTitleLabel()
        setupNameTextField()
        // Do any additional setup after loading the view.
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = NewActivityController.bgColorTransparent
        titleLabel.text = "任务名称："
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.backgroundColor = NewActivityController.bgColorTransparent
        nameTextField.placeholder = "请输入任务名称"
        nameTextField.font = UIFont.preferredFont(forTextStyle: .body)
        nameTextField.delegate = self
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getName() -> String? {
        return nameTextField.text
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
