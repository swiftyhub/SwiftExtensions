//
//  String+Utilities.swift
//  Kevin McKee
//
//  Created by Kevin McKee on 09/1/15.
//  Copyright © 2015 Kevin McKee. All rights reserved.
//

import Foundation

extension String {
 
    // 👍 Returns the string length
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    // 👍 Creates a localized String from this String
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
    
    // 👍 Returns a localized String with a comment
    func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: comment)
    }
    
    // 👍 Trims the string
    func trim() -> String {
        let trimmed = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        return trimmed
    }

    // 👍 Creates a random string with the specifed length
    static func randomStringWithLength(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: length)
        
        for (var i=0; i < length; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }

        let out = "\(randomString)"
        return out
    }
    
    // 👍 Regex to find matches
    func isMatch(regex: String, options: NSRegularExpressionOptions) -> Bool {
        var error: NSError?
        var exp: NSRegularExpression?
        do {
            exp = try NSRegularExpression(pattern: regex, options: options)
        } catch let error1 as NSError {
            error = error1
            exp = nil
        }
        
        if let error = error {
            print(error.description)
        }
        let matchCount = exp!.numberOfMatchesInString(self, options: [], range: NSMakeRange(0, self.length))
        return matchCount > 0
    }
}

