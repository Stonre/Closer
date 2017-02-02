//
//  OwnActivityCell.swift
//  Closer
//
//  Created by Kami on 2017/1/23.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class OwnActivityCell: ActivityCell {
    
    override var activity: Activity? {
        didSet{
            if activity != nil {
                setupViews(userProfileImageViewWidth: 0.0, userNameLabelHeight: 0.0)
            }
        }
    }
}
