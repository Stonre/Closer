//
//  ViewController.swift
//  ActivityReview
//
//  Created by Lei Ding on 2/10/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class FullActivityReviewViewController: ActivityReviewViewController {
    
    let updateData = UpdateData.sharedInstance
    
    var state: Int = 0 // 0 - all included, 1 - time Start and timeEnd excluded
    
    let activityName: UILabel = {
        let label = UILabel()
        label.text = "任务名称"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var userProfileImageUrl: NSURL? {
        didSet {
            DispatchQueue.global(qos: .userInteractive).async {
                if let imageData = NSData(contentsOf: self.userProfileImageUrl as! URL) {
                    DispatchQueue.main.async {
                        self.userPortrait.image = UIImage(data: imageData as Data)
                    }
                }
            }
        }
    }

    
    let infoView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "mybackground")!)
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        //let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        //blurEffectView.frame = view.bounds
        //blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(blurEffectView)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.masksToBounds = false
        view.backgroundColor = UIColor(red:0.96, green:0.65, blue:0.14, alpha:0.72)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let releaserView: UIView = {
        let view = UIView()
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let locationText: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 0.149, green: 0.1176, blue: 0.0902, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    let backgroundImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    let tagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tag: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.149, green: 0.1176, blue: 0.0902, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionView: UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userPortrait: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let timeStartLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.149, green: 0.1176, blue: 0.0902, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeEndLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.149, green: 0.1176, blue: 0.0902, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let notInterestedButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "不感兴趣"), for: .normal)
//        button.addTarget(self, action: #selector(selectContactsButton(_:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let notClearButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "描述不清"), for: .normal)
//        button.addTarget(self, action: #selector(selectContactsButton(_:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let goParticipateInButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "加入活动Go!"), for: .normal)
        button.addTarget(self, action: #selector(setParticipate), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let startLabel: UILabel = {
        let label = UILabel()
        label.text = "开始"
        label.textAlignment = .left
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endLabel: UILabel = {
        let label = UILabel()
        label.text = "结束"
        label.textAlignment = .left
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        setupInfoView()
        setupActivityName()
        setupReleaserView()
        setupTimeAndLocationView()
        setupLocationInfo()
        //setupTagView()
        setupDescriptionView()
        setupReleaserInfo()
        setupBottomStack()
        if state == 0 {
            setupTimeLabel()
        }
        loadData()
    }
    
    func setupInfoView() {
        view.addSubview(infoView)
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        if state == 0 {
            infoView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        } else {
            infoView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        }
        
    }
    
    func setParticipate() {
        guard let userId = FIRAuth.auth()?.currentUser?.uid else {
            print("Error: no current user id")
            return
        }
        
        updateData.addParticipant(participantId: userId, activity: activity!)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func loadData() {
        if let activity = activity as? GeneralActivity {
            activityName.text = activity.name
            userName.text = activity.userReleasing.userName
            if let portraitUrl = activity.userReleasing.userProfileImageUrl {
                userProfileImageUrl = NSURL(string: portraitUrl)
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            if let timeStart = activity.timeStart {
                timeStartLabel.text = dateFormatter.string(from: timeStart)
                if let timeEnd = activity.timeEnd {
                    timeEndLabel.text = dateFormatter.string(from: timeEnd)
                }
                else {
                    timeEndLabel.text = "不限"
                }
            }
            else {
                state = 1
            }
            if activity.isOnline {
                locationIconView.image = #imageLiteral(resourceName: "online")
                locationText.setTitle("在线", for: .normal)
            } else {
                locationIconView.image = #imageLiteral(resourceName: "map-icon")
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(activity.location!, completionHandler: { (placemarks, error) -> Void in
                    var placeMark: CLPlacemark!
                    placeMark = placemarks?[0]
                    let placeName = placeMark.addressDictionary?["Name"] as? NSString
                    let placeStreet = placeMark.addressDictionary?["Thoroughfare"] as? NSString
                    let placeCity = placeMark.addressDictionary?["City"] as? NSString
                    self.locationText.setTitle("\(placeName),\(placeStreet),\(placeCity)", for: .normal)
                })
            }
            
            var tags: String = "标签： "
            activity.tags.forEach({ (tag) in
                tags.append(tag)
                tags.append("; ")
            })
            tag.text = tags
            
            let description = generateHtmlBody(description: activity.description)
            let htm = prepareWebContent(body: description, css: ["https://news-at.zhihu.com/css/news_qa.auto.css"])
            DispatchQueue.main.async { [weak self] in
                self!.descriptionView.loadHTMLString(htm, baseURL: nil)
            }
        }
    }
    
    func setupActivityName() {
        infoView.addSubview(activityName)
        activityName.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 40).isActive = true
        activityName.leftAnchor.constraint(equalTo: infoView.leftAnchor).isActive = true
        activityName.rightAnchor.constraint(equalTo: infoView.rightAnchor).isActive = true
        activityName.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupReleaserView() {
        infoView.addSubview(releaserView)
        releaserView.topAnchor.constraint(equalTo: activityName.bottomAnchor, constant: 2).isActive = true
        releaserView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        releaserView.widthAnchor.constraint(equalTo: activityName.widthAnchor, multiplier: 0.4).isActive = true
        releaserView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupTimeAndLocationView() {
        infoView.addSubview(timeView)
        timeView.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        timeView.topAnchor.constraint(equalTo: releaserView.bottomAnchor, constant: 10).isActive = true
        timeView.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 0.5).isActive = true
        timeView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.8).isActive = true
        
        infoView.addSubview(locationView)
        if state == 0 {
            locationView.rightAnchor.constraint(equalTo: infoView.rightAnchor).isActive = true
            locationView.topAnchor.constraint(equalTo: timeView.bottomAnchor).isActive = true
            locationView.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 1).isActive = true
            locationView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true
        } else {
            locationView.rightAnchor.constraint(equalTo: infoView.rightAnchor).isActive = true
            locationView.topAnchor.constraint(equalTo: releaserView.bottomAnchor).isActive = true
            locationView.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 1).isActive = true
            locationView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true

        }
        
    }
    
    func setupTimeLabel() {
        timeView.addSubview(startLabel)
        startLabel.leftAnchor.constraint(equalTo: timeView.leftAnchor).isActive = true
        startLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 2).isActive = true
        startLabel.bottomAnchor.constraint(equalTo: timeView.centerYAnchor).isActive = true
        //startLabel.widthAnchor.constraint(equalTo: startLabel.heightAnchor).isActive = true
        timeView.addSubview(timeStartLabel)
        timeStartLabel.leftAnchor.constraint(equalTo: startLabel.leftAnchor, constant: 40).isActive = true
        timeStartLabel.rightAnchor.constraint(equalTo: timeView.rightAnchor).isActive = true
        timeStartLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 2).isActive = true
        timeStartLabel.bottomAnchor.constraint(equalTo: timeView.centerYAnchor, constant: -1).isActive = true
        timeView.addSubview(endLabel)
        endLabel.leftAnchor.constraint(equalTo: timeView.leftAnchor).isActive = true
        endLabel.topAnchor.constraint(equalTo: timeView.centerYAnchor, constant: 2).isActive = true
        endLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor).isActive = true
        //endLabel.widthAnchor.constraint(equalTo: endLabel.heightAnchor).isActive = true
        timeView.addSubview(timeEndLabel)
        timeEndLabel.topAnchor.constraint(equalTo: timeView.centerYAnchor, constant: 2).isActive = true
        timeEndLabel.rightAnchor.constraint(equalTo: timeView.rightAnchor).isActive = true
        timeEndLabel.leftAnchor.constraint(equalTo: endLabel.leftAnchor, constant: 40).isActive = true
        timeEndLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor).isActive = true
    }
    
    /*func setupTagView() {
        infoView.addSubview(tagView)
        tagView.leftAnchor.constraint(equalTo: infoView.leftAnchor).isActive = true
        tagView.rightAnchor.constraint(equalTo: infoView.rightAnchor).isActive = true
        tagView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true
        tagView.topAnchor.constraint(equalTo: locationView.bottomAnchor).isActive = true
        
        tagView.addSubview(tag)
        tag.leftAnchor.constraint(equalTo: tagView.leftAnchor, constant: 25).isActive = true
        tag.rightAnchor.constraint(equalTo: tagView.rightAnchor, constant: 4).isActive = true
        tag.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 2).isActive = true
        tag.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 2).isActive = true
    }*/
    
    func setupDescriptionView() {
        view.addSubview(descriptionView)
        descriptionView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 2).isActive = true
        descriptionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupReleaserInfo() {
        releaserView.addSubview(userPortrait)
        userPortrait.topAnchor.constraint(equalTo: releaserView.topAnchor, constant: 0).isActive = true
        userPortrait.bottomAnchor.constraint(equalTo: releaserView.bottomAnchor, constant: 0).isActive = true
        userPortrait.rightAnchor.constraint(equalTo: releaserView.centerXAnchor, constant: -20).isActive = true
        userPortrait.widthAnchor.constraint(equalTo: releaserView.heightAnchor, multiplier: 1).isActive = true
        releaserView.addSubview(userName)
        userName.topAnchor.constraint(equalTo: releaserView.topAnchor, constant: 0).isActive = true
        userName.bottomAnchor.constraint(equalTo: releaserView.bottomAnchor, constant: 0).isActive = true
        userName.rightAnchor.constraint(equalTo: releaserView.rightAnchor, constant: -5).isActive = true
        userName.leftAnchor.constraint(equalTo: userPortrait.rightAnchor, constant: 5).isActive = true
    }
    
    func setupLocationInfo() {
        locationView.addSubview(locationIconView)
        locationIconView.rightAnchor.constraint(equalTo: locationView.centerXAnchor, constant: -20).isActive = true
        locationIconView.centerYAnchor.constraint(equalTo: locationView.centerYAnchor).isActive = true
        locationIconView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        locationIconView.widthAnchor.constraint(equalTo: locationIconView.heightAnchor).isActive = true
        
        locationView.addSubview(locationText)
        locationText.leftAnchor.constraint(equalTo: locationIconView.centerXAnchor, constant: 20).isActive = true
        locationText.rightAnchor.constraint(equalTo: locationView.rightAnchor, constant: 2).isActive = true
        locationText.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 2).isActive = true
        locationText.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 2).isActive = true
    }
    
    func setupBottomStack() {
        let viewContainer1 = UIView()
        let viewContainer2 = UIView()
        let viewContainer3 = UIView()
        bottomStackView.addArrangedSubview(viewContainer1)
        bottomStackView.addArrangedSubview(viewContainer2)
        bottomStackView.addArrangedSubview(viewContainer3)
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        viewContainer1.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        viewContainer1.translatesAutoresizingMaskIntoConstraints = false
        viewContainer2.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        viewContainer2.translatesAutoresizingMaskIntoConstraints = false
        viewContainer3.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        viewContainer3.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
        bottomStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        bottomStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        viewContainer1.addSubview(notInterestedButton)
        notInterestedButton.leftAnchor.constraint(equalTo: viewContainer1.leftAnchor, constant: 0).isActive = true
        notInterestedButton.rightAnchor.constraint(equalTo: viewContainer1.rightAnchor, constant: 0).isActive = true
        notInterestedButton.topAnchor.constraint(equalTo: viewContainer1.topAnchor, constant: 0).isActive = true
        notInterestedButton.bottomAnchor.constraint(equalTo: viewContainer1.bottomAnchor, constant: 0).isActive = true
        
        viewContainer2.addSubview(notClearButton)
        notClearButton.leftAnchor.constraint(equalTo: viewContainer2.leftAnchor, constant: 0).isActive = true
        notClearButton.rightAnchor.constraint(equalTo: viewContainer2.rightAnchor, constant: 0).isActive = true
        notClearButton.topAnchor.constraint(equalTo: viewContainer2.topAnchor, constant: 0).isActive = true
        notClearButton.bottomAnchor.constraint(equalTo: viewContainer2.bottomAnchor, constant: 0).isActive = true
        
        viewContainer3.addSubview(goParticipateInButton)
        goParticipateInButton.leftAnchor.constraint(equalTo: viewContainer3.leftAnchor, constant: 0).isActive = true
        goParticipateInButton.rightAnchor.constraint(equalTo: viewContainer3.rightAnchor, constant: 0).isActive = true
        goParticipateInButton.topAnchor.constraint(equalTo: viewContainer3.topAnchor, constant: 0).isActive = true
        goParticipateInButton.bottomAnchor.constraint(equalTo: viewContainer3.bottomAnchor, constant: 0).isActive = true
    }
}

