//
//  ViewController.swift
//  ActivityReview
//
//  Created by Lei Ding on 2/10/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit

class ActivityReviewController: UIViewController {
    
    let activityName: UILabel = {
        let label = UILabel()
        label.text = "任务名称"
        label.backgroundColor = .yellow
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaserView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tagView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionView: UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userPortrait: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        edgesForExtendedLayout = []
        setupActivityName()
        setupReleaserView()
        setupTimeAndLocationView()
        setupTagView()
        setupDescriptionView()
        setupreleaserInfo()
        setupBottomStack()
    }
    
    func setupActivityName() {
        view.addSubview(activityName)
        activityName.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityName.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        activityName.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        activityName.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setupReleaserView() {
        view.addSubview(releaserView)
        releaserView.topAnchor.constraint(equalTo: activityName.bottomAnchor, constant: 2).isActive = true
        releaserView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        releaserView.widthAnchor.constraint(equalTo: activityName.widthAnchor, multiplier: 0.4).isActive = true
        releaserView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.56).isActive = true
    }
    
    func setupTimeAndLocationView() {
        view.addSubview(timeView)
        timeView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        timeView.topAnchor.constraint(equalTo: releaserView.bottomAnchor).isActive = true
        timeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        timeView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true
        
        view.addSubview(locationView)
        locationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        locationView.topAnchor.constraint(equalTo: releaserView.bottomAnchor).isActive = true
        locationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        locationView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupTagView() {
        view.addSubview(tagView)
        tagView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tagView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tagView.heightAnchor.constraint(equalTo: activityName.heightAnchor, multiplier: 0.7).isActive = true
        tagView.topAnchor.constraint(equalTo: locationView.bottomAnchor).isActive = true
    }
    
    func setupDescriptionView() {
        view.addSubview(descriptionView)
        descriptionView.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 2).isActive = true
        descriptionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupreleaserInfo() {
        releaserView.addSubview(userName)
        userName.topAnchor.constraint(equalTo: releaserView.topAnchor, constant: 0).isActive = true
        userName.bottomAnchor.constraint(equalTo: releaserView.bottomAnchor, constant: 0).isActive = true
        userName.leftAnchor.constraint(equalTo: releaserView.leftAnchor).isActive = true
        userName.widthAnchor.constraint(equalTo: releaserView.heightAnchor, multiplier: 1).isActive = true
        releaserView.addSubview(userPortrait)
        userPortrait.topAnchor.constraint(equalTo: releaserView.topAnchor, constant: 0).isActive = true
        userPortrait.bottomAnchor.constraint(equalTo: releaserView.bottomAnchor, constant: 0).isActive = true
        userPortrait.rightAnchor.constraint(equalTo: releaserView.rightAnchor, constant: 0).isActive = true
        userPortrait.widthAnchor.constraint(equalTo: releaserView.widthAnchor, multiplier: 0.75).isActive = true
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
        viewContainer1.backgroundColor = .yellow
        viewContainer1.translatesAutoresizingMaskIntoConstraints = false
        viewContainer2.backgroundColor = .yellow
        viewContainer2.translatesAutoresizingMaskIntoConstraints = false
        viewContainer3.backgroundColor = .yellow
        viewContainer3.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
        bottomStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        bottomStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
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
                body += "<p><img class=\"content-image\" src=\($0) alt=\"\" /></p>"
                break
            case ContentType.Hyperlink:
                var contents: [String] = $0.content.components(separatedBy: "::::::")
                body += "<a href=\"\(contents[0])\">\(contents[1])</a>"
                break
            case ContentType.Text:
                body += "<p>(\($0.content))</p>"
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
        html += "</head>"
        
        html += "<body>"
        html += body
        html += "</body>"
        
        html += "</html>"
        
        return html
    }
}

