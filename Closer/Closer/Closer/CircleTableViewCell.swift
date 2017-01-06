//
//  CircleTableViewCell.swift
//  Closer
//
//  Created by Kami on 2017/1/6.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import UIKit

class CircleTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var activity: Activity! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let generalActivity = activity as? GeneralActivity {
            userNameLabel.text = generalActivity.userReleasing.userName
            activityTitleLabel.text = generalActivity.name
            let date = Date()
            let calendar = NSCalendar.current
            let component = calendar.dateComponents([.hour, .minute], from: date)
            timeLabel.text = String(component.hour!) + ":" + String(component.minute!)
            activityContentLabel.text = generalActivity.description.text
        }
        
    }

}
