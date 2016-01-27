//
//  TodayViewController.swift
//  Urban Dic Wedgit
//
//  Created by Maimaitiming Abudukadier on 1/24/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    @IBAction func openUrbanDic(sender: UIButton) {
        let url = NSURL(string: "UrbandDic://")!
        extensionContext?.openURL(url, completionHandler: { (Bool) -> Void in
            
        })
    }
    
}
