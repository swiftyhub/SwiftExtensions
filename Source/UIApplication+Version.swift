//
//  UIApplication+Version.swift
//  Kevin McKee
//
//  Created by Kevin McKee on 09/1/15.
//  Copyright © 2015 Kevin McKee. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func version() -> String {
        
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }
    
    func buildNo() -> String {
        
        return NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
    }
    
    func versionBuildNo() -> String {
        
        let version = self.version()
        let build = self.buildNo()
        return "\(version).\(build)"
        //return "\(version) (Build \(build))"
    }
}

