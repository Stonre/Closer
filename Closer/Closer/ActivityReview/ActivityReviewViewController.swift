//
//  ActivityReviewViewController.swift
//  Closer
//
//  Created by Kami on 2017/3/10.
//  Copyright © 2017年 Lei Ding. All rights reserved.
//

import UIKit

class ActivityReviewViewController: UIViewController {
    
    var activity: Activity? {
        didSet {
            loadData()
        }
    }

    func loadData() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateHtmlBody(description: [DescriptionUnit]) -> String {
        var body: String = "<div class = \"content\">"
        
        description.forEach {
            switch $0.type {
            case ContentType.Image.rawValue:
                print($0)
                body += "<p><img class=\"content-image\" src=\($0.content) alt=\"\" /></p>"
                break
            case ContentType.Hyperlink.rawValue:
                var contents: [String] = $0.content.components(separatedBy: "::::::")
                body += "<a href=\"\(contents[1])\">\(contents[0])</a>"
                break
            case ContentType.Text.rawValue:
                body += "<p>\($0.content)</p>"
                break
            default: break
            }
        }
        
        body += "</div>"
        
        return body
    }
    
    func prepareWebContent(body: String, css: [String]) -> String {
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
