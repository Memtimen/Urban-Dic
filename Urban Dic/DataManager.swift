//
//  DataManager.swift
//  Urban Dic
//
//  Created by Maimaitiming Abudukadier on 1/24/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit

var dicData = NSDictionary()

class DataManager: NSObject {
    static let sharedInstance = DataManager()
    
    func getData(keyWord:String){
        guard let url = NSURL(string: "http://api.urbandictionary.com/v0/define?term=\(keyWord)") else {
            return
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, err) -> Void in
            if err == nil && data != nil {
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                        dicData = json
                        print(dicData)
                    }
                } catch {}
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("update Data", object: nil)
            })
            }.resume()
    }
}
