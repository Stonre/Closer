//
//  ViewController.swift
//  ActivityReview
//
//  Created by Lei Ding on 2/10/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit
import CoreLocation

class ActivityReviewController: UIViewController {
    
    var activity: Activity?
    
//    init(activity a: Activity) {
//        activity = a
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    let activityName: UILabel = {
        let label = UILabel()
        label.text = "任务名称"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "mybackground")!)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let releaserView: UIView = {
        let view = UIView()
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
        label.textAlignment = .left
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
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
//        button.addTarget(self, action: #selector(selectContactsButton(_:)), for: .touchUpInside)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.91, green:0.93, blue:0.95, alpha:1.0)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target: nil, action: nil)
        loadData()
        setupInfoView()
        setupActivityName()
        setupReleaserView()
        setupTimeAndLocationView()
        setupLocationInfo()
        setupTagView()
        setupDescriptionView()
        setupreleaserInfo()
        setupBottomStack()
        setupTimeLabel()
    }
    
    func setupInfoView() {
        view.addSubview(infoView)
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    func loadData() {
        if let activity = activity as? GeneralActivity {
            activityName.text = activity.name
            userName.text = activity.userReleasing.userName
            userPortrait.image = UIImage(data: activity.userReleasing.headPortrait as! Data)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            timeLabel.text = dateFormatter.string(from: activity.timeStart!)
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
        activityName.heightAnchor.constraint(equalToConstant: 55).isActive = true
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
        timeView.leftAnchor.constraint(equalTo: infoView.leftAnchor).isActive = true
        timeView.topAnchor.constraint(equalTo: releaserView.bottomAnchor).isActive = true
        timeView.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 0.5).isActive = true
        timeView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true
        
        infoView.addSubview(locationView)
        locationView.rightAnchor.constraint(equalTo: infoView.rightAnchor).isActive = true
        locationView.topAnchor.constraint(equalTo: releaserView.bottomAnchor).isActive = true
        locationView.widthAnchor.constraint(equalTo: infoView.widthAnchor, multiplier: 0.5).isActive = true
        locationView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupTimeLabel() {
        timeView.addSubview(timeLabel)
        timeLabel.leftAnchor.constraint(equalTo: timeView.leftAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: timeView.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 2).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 2).isActive = true
    }
    
    func setupTagView() {
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
    }
    
    func setupDescriptionView() {
        view.addSubview(descriptionView)
        descriptionView.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 2).isActive = true
        descriptionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupreleaserInfo() {
        releaserView.addSubview(userPortrait)
        userPortrait.topAnchor.constraint(equalTo: releaserView.topAnchor, constant: 0).isActive = true
        userPortrait.bottomAnchor.constraint(equalTo: releaserView.bottomAnchor, constant: 0).isActive = true
        userPortrait.rightAnchor.constraint(equalTo: releaserView.centerXAnchor, constant: -10).isActive = true
        userPortrait.widthAnchor.constraint(equalTo: releaserView.heightAnchor, multiplier: 1).isActive = true
        releaserView.addSubview(userName)
        userName.topAnchor.constraint(equalTo: releaserView.topAnchor, constant: 0).isActive = true
        userName.bottomAnchor.constraint(equalTo: releaserView.bottomAnchor, constant: 0).isActive = true
        userName.rightAnchor.constraint(equalTo: releaserView.rightAnchor, constant: 0).isActive = true
        userName.leftAnchor.constraint(equalTo: releaserView.centerXAnchor, constant: 5).isActive = true
    }
    
    func setupLocationInfo() {
        locationView.addSubview(locationIconView)
        locationIconView.leftAnchor.constraint(equalTo: locationView.leftAnchor, constant: 10).isActive = true
        locationIconView.centerYAnchor.constraint(equalTo: locationView.centerYAnchor).isActive = true
        locationIconView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        locationIconView.widthAnchor.constraint(equalTo: locationIconView.heightAnchor).isActive = true
        
        locationView.addSubview(locationText)
        locationText.leftAnchor.constraint(equalTo: locationIconView.rightAnchor, constant: 6).isActive = true
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
    
    private func generateHtmlBody(description: [DescriptionUnit]) -> String {
        var body: String = "<div class = \"content\">"
        
        description.forEach {
            switch $0.type {
            case ContentType.Image:
                print($0)
                body += "<p><img class=\"content-image\" src=\($0.content) alt=\"\" /></p>"
                break
            case ContentType.Hyperlink:
                var contents: [String] = $0.content.components(separatedBy: "::::::")
                body += "<a href=\"\(contents[1])\">\(contents[0])</a>"
                break
            case ContentType.Text:
                body += "<p>\($0.content)</p>"
                break
            default: break
            }
        }
        
        body += "</div>"
        
        return body
    }
    
    private func prepareWebContent(body: String, css: [String]) -> String {
        var html = "<html>"
        html += "<head>"
        css.forEach { html += "<link rel=\"stylesheet\" href=\($0)>" }
        html += "<style>img{max-width:320px !important;}</style>"
        html += "</head>"
        html += "<body>"
        html += "<div class=\"main-wrap content-wrap\">"
        html += "<div class=\"content-inner\">"
        html += "<div class=\"content\">"
        html += body
        html += "</div>"
        html += "</div>"
        html += "</div>"
        html += "</body>"
        
        html += "</html>"
        
        return html
    }
}

