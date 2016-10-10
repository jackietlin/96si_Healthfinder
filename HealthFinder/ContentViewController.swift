//
//  ContentViewController.swift
//  HealthFinder
//
//  Created by Jacqueline Lin on 10/10/16.
//  Copyright © 2016 CS96SI. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet var contentScrollView: UIScrollView!
    var content:[NSDictionary]?
    @IBOutlet var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        contentLabel.text = content?[0]["Content"] as? String
        let htmlContent = content?[0]["Content"] as? String
        let attrStr = try! NSAttributedString(
            data: htmlContent!.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        contentLabel.attributedText = attrStr
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
