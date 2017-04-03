//
//  PersonalInfoCell.swift
//  Closer
//
//  Created by Lei Ding on 3/26/17.
//  Copyright © 2017 Lei Ding. All rights reserved.
//

import UIKit

class PersonalInfoCell: UITableViewCell {
    
    var name: String?
    var content: String?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(nameLabel)
    }
    
}
