//
//  AchievementReward.swift
//  Closer
//
//  Created by Kami on 2016/12/29.
//  Copyright © 2016年 Kaiming. All rights reserved.
//

import Foundation

class AchievementReward: Reward {
    var source = RewardSource.Achievement
    var requiredAchivement: Achievement?
    
    func getRequiredAchievement() {
        return requiredAchivement
    }
    
}
