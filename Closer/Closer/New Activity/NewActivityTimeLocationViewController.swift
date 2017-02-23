//
//  NewActivityTimeLocationViewController.swift
//  Closer
//
//  Created by Kami on 2017/2/20.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class NewActivityTimeLocationViewController: NewActivityContentViewController {
    
    let timeTitleLabel = UILabel()
    let startTimeLabel = UILabel()
    let startTime = UITextField()
    let endTimeLabel = UILabel()
    let endTime = UITextField()
    let locationTitleLabel = UILabel()
    let locationTextField = UITextField()
    let tagTitleLabel = UILabel()
    let tagTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        contentIndex = 2
        view.backgroundColor = .white
        setupTimeTitleLabel()
        setupStartTime()
        setupEndTime()
        setupLocationTitleLabel()
        setupLocationTextField()
        setupTagTitleLabel()
        setupTagTextField()
        // Do any additional setup after loading the view.
    }
    
    private func setupTimeTitleLabel() {
        view.addSubview(timeTitleLabel)
        timeTitleLabel.backgroundColor = .white
        timeTitleLabel.text = "任务周期："
        timeTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        timeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        timeTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    private func setupStartTime() {
        view.addSubview(startTimeLabel)
        startTimeLabel.backgroundColor = .white
        startTimeLabel.text = "起始时间"
        startTimeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        startTimeLabel.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 8).isActive = true
        startTimeLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        
        view.addSubview(startTime)
        startTime.placeholder = "HH:mm:ss MM/dd/yyyy"
        startTime.font = UIFont.preferredFont(forTextStyle: .body)
        startTime.translatesAutoresizingMaskIntoConstraints = false
        startTime.leftAnchor.constraint(equalTo: startTimeLabel.rightAnchor, constant: 8).isActive = true
        startTime.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor, constant: 0).isActive = true
        startTime.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func setupEndTime() {
        view.addSubview(endTimeLabel)
        endTimeLabel.backgroundColor = .white
        endTimeLabel.text = "结束时间"
        endTimeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 8).isActive = true
        endTimeLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        
        view.addSubview(endTime)
        endTime.placeholder = "HH:mm:ss MM/dd/yyyy"
        endTime.font = UIFont.preferredFont(forTextStyle: .body)
        endTime.translatesAutoresizingMaskIntoConstraints = false
        endTime.leftAnchor.constraint(equalTo: endTimeLabel.rightAnchor, constant: 8).isActive = true
        endTime.centerYAnchor.constraint(equalTo: endTimeLabel.centerYAnchor, constant: 0).isActive = true
        endTime.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func setupLocationTitleLabel() {
        view.addSubview(locationTitleLabel)
        locationTitleLabel.backgroundColor = .white
        locationTitleLabel.text = "任务地点："
        locationTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.topAnchor.constraint(equalTo: endTimeLabel.bottomAnchor, constant: 12).isActive = true
        locationTitleLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 0).isActive = true
    }
    
    private func setupLocationTextField() {
        view.addSubview(locationTextField)
        locationTextField.backgroundColor = .white
        locationTextField.placeholder = "请输入任务地点"
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 8).isActive = true
        locationTextField.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        locationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTagTitleLabel() {
        view.addSubview(tagTitleLabel)
        tagTitleLabel.backgroundColor = .white
        tagTitleLabel.text = "任务标签："
        tagTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        tagTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tagTitleLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 12).isActive = true
        tagTitleLabel.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 0).isActive = true
    }
    
    private func setupTagTextField() {
        view.addSubview(tagTextField)
        tagTextField.backgroundColor = .white
        tagTextField.placeholder = "请输入任务标签"
        tagTextField.translatesAutoresizingMaskIntoConstraints = false
        tagTextField.topAnchor.constraint(equalTo: tagTitleLabel.bottomAnchor, constant: 8).isActive = true
        tagTextField.leftAnchor.constraint(equalTo: timeTitleLabel.leftAnchor, constant: 8).isActive = true
        tagTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tagTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func getLocation() -> String? {
        return locationTextField.text
    }
    
    func getTags() -> String? {
        return tagTextField.text
    }
    
    func getStartingTime() ->Date? {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss MM/dd/yyyy"
        return timeFormatter.date(from: startTime.text!)
    }
    
    func getEndTime() -> Date? {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss MM/dd/yyyy"
        return timeFormatter.date(from: endTime.text!)
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
