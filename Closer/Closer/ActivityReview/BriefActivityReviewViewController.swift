//
//  BriefActivityReviewViewController.swift
//  Closer
//
//  Created by Kami on 2017/3/10.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class BriefActivityReviewViewController: ActivityReviewViewController {
    
    var activityNameLabel = UILabel()
    var releaserNameLabel = UILabel()
    var releaserProfileImageView = UIImageView()
    var timeLabel = UILabel()
    var activityDescriptionView = UIWebView()
    var moreButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupActivityNameLabel()
        setupReleaserProfileImageView()
        setupReleaserNameLabel()
        setupTimeLabel()
        setupActivityDescriptionView()
        setupMoreButton()
        loadData()
        // Do any additional setup after loading the view.
    }

    private func setupActivityNameLabel() {
        view.addSubview(activityNameLabel)
//        activityNameLabel.backgroundColor = .blue
        activityNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        activityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        activityNameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        activityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func setupReleaserProfileImageView() {
        view.addSubview(releaserProfileImageView)
//        releaserProfileImageView.backgroundColor = .red
//        releaserProfileImageView.contentMode = .scaleToFill
        releaserProfileImageView.layer.cornerRadius = 4
        releaserProfileImageView.layer.borderColor = UIColor.white.cgColor
        releaserProfileImageView.layer.borderWidth = 1
        releaserProfileImageView.clipsToBounds = true
        
        releaserProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        releaserProfileImageView.topAnchor.constraint(equalTo: activityNameLabel.bottomAnchor, constant: 8).isActive = true
        releaserProfileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        releaserProfileImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        releaserProfileImageView.widthAnchor.constraint(equalTo: releaserProfileImageView.heightAnchor, constant: 0).isActive = true
    }
    
    private func setupReleaserNameLabel() {
        view.addSubview(releaserNameLabel)
//        releaserNameLabel.backgroundColor = .yellow
        releaserNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        releaserNameLabel.translatesAutoresizingMaskIntoConstraints = false
        releaserNameLabel.centerYAnchor.constraint(equalTo: releaserProfileImageView.centerYAnchor, constant: 0).isActive = true
        releaserNameLabel.leftAnchor.constraint(equalTo: releaserProfileImageView.rightAnchor, constant: 4).isActive = true
        releaserNameLabel.heightAnchor.constraint(equalTo: releaserProfileImageView.heightAnchor, constant: 0).isActive = true
        releaserNameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupTimeLabel() {
        view.addSubview(timeLabel)
//        timeLabel.backgroundColor = .blue
        timeLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        timeLabel.textAlignment = .right
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: releaserNameLabel.topAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: releaserNameLabel.centerYAnchor, constant: 0).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupActivityDescriptionView() {
        view.addSubview(activityDescriptionView)
//        activityDescriptionView.backgroundColor = .blue
        activityDescriptionView.isHidden = true
        
        activityDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        activityDescriptionView.topAnchor.constraint(equalTo: releaserNameLabel.bottomAnchor, constant: 12).isActive = true
        activityDescriptionView.leftAnchor.constraint(equalTo: releaserProfileImageView.leftAnchor, constant: 0).isActive = true
        activityDescriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityDescriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
    }
    
    private func setupMoreButton() {
        view.addSubview(moreButton)
        moreButton.setTitle("查看详情", for: .normal)
        moreButton.isHidden = true
        
        moreButton.backgroundColor = UIColor(red:0.94, green:0.55, blue:0.28, alpha:1.0)
        moreButton.addTarget(self, action: #selector(touchMoreButton), for: .touchUpInside)
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        moreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
//        moreButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func touchMoreButton() {
        if activity != nil {
            let fullViewController = FullActivityReviewViewController()
            fullViewController.activity = self.activity
            navigationController?.pushViewController(fullViewController, animated: true)
        }
    }
    
    override func loadData() {
        if let activity = activity as? GeneralActivity {
            activityNameLabel.text = activity.name
            releaserNameLabel.text = activity.userReleasing.userName
            if let url = URL(string: activity.userReleasing.userProfileImageUrl!) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    DispatchQueue.main.async {
                        self.releaserProfileImageView.image = UIImage(data: data!)
                    }
                    
                }).resume()
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            timeLabel.text = dateFormatter.string(from: activity.timeStart!)
            
            let description = generateHtmlBody(description: activity.description)
            let htmlText = prepareWebContent(body: description, css: ["https://news-at.zhihu.com/css/news_qa.auto.css"])
            DispatchQueue.main.async { [weak self] in
                self!.activityDescriptionView.loadHTMLString(htmlText, baseURL: nil)
            }
            activityDescriptionView.isHidden = false
            moreButton.isHidden = false
        }
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
