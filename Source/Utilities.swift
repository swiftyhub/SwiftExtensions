//
//  Utilities.swift
//  Kevin McKee
//
//  Created by Kevin McKee on 09/10/15.
//  Copyright © 2015 Kevin McKee, Inc. All rights reserved.
//

import Foundation

/// 👍 Tests to make sure an URL is actually reachable and not a 404 or 500 error
func reachable(url: NSURL) -> Bool {
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "HEAD"
    var reached: Bool = false
    
    let semaphore = dispatch_semaphore_create(0)
    
    let task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
        
        if (data != nil) {
            if let httpResponse = response as? NSHTTPURLResponse {
                
                print("Received status code \(httpResponse.statusCode)")
                
                if (httpResponse.statusCode == 200) {
                    reached = true
                }
            }
        }
        dispatch_semaphore_signal(semaphore)
    }
    task.resume()
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    
    print("Reachable ? \(reached)")
    
    return reached
    
}

/// 👍 Convenience reachability method
func reachable(urlString: String) -> Bool {
    let url = NSURL(string: urlString)
    return reachable(url!)
}


/// 👍 Performs a simple delay function. Example: delay(4.0) { // Do something ...}
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

/// 👍 Convenience method to get the application documents URL
func getDocumentsURL() -> NSURL {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    return documentsURL
}

/// 👍 Convenience method to get the file URL in the documents directory
func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}
