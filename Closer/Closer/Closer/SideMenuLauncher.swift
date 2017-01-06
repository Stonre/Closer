//
//  SideMenuLauncher.swift
//  Closer
//
//  Created by Kami on 2017/1/7.
//  Copyright © 2017年 Kaiming. All rights reserved.
//

import Foundation
import UIKit

class SideMenuLauncher: NSObject {
    
//    var visibleView: UIView?
    var blackView = UIView()
    
    var sideMenuViewController = SideMenuTableViewController()
    var sideMenuView: UITableView {
        get {
            return sideMenuViewController.tableView
        }
    }
    let menuWidthRatio: CGFloat = 0.6
    var menuY: CGFloat = 25
    var menuWidth: CGFloat = 0
    var menuHeight: CGFloat = 0
    
    func prepareForView() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.alpha = 0
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(menuWillDisappear)))
            window.addSubview(blackView)
            
            menuY = UIApplication.shared.statusBarFrame.maxY
            menuWidth = blackView.bounds.maxX * menuWidthRatio
            menuHeight = blackView.bounds.maxY
            sideMenuView.frame = CGRect(x: 0, y: menuY, width: 0, height: menuHeight)
            sideMenuView.backgroundColor = UIColor.white
            
            window.addSubview(sideMenuView)
        }
        
        
    }
    
    func menuWillShow() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0.5
            self.sideMenuView.frame = CGRect(x: 0, y: self.menuY, width: self.menuWidth, height: self.menuHeight)
        }
    }
    
    func menuWillDisappear() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.sideMenuView.frame = CGRect(x: 0, y: self.menuY, width: 0, height: self.menuHeight)
        }

    }
    
}
