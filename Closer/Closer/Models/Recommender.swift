//
//  Recommendation.swift
//  Closer
//
//  Created by Kami on 2016/12/29.
//  Copyright © 2016年 Kaiming. All rights reserved.
//

import Foundation

protocol Recommender {
    var recommendations: Array<Activity> { get set }
    var recommenderContext: RecommenderContext { get set }
    
    mutating func getRecommendations()
}
