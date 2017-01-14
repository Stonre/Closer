//
//  SideMenuCategoryTableViewCell.swift
//  Closer
//
//  Created by Kami on 2017/1/7.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import UIKit

class SideMenuCategoryTableViewCell: UITableViewCell {
    
    var category: String? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        textLabel?.text = category
    }
}
