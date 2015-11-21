//
//  RequestHandler.swift
//  AiCure
//
//  Created by Mike Wang on 10/21/15.
//  Copyright © 2015 Mike Wang. All rights reserved.
//

import Foundation

class RequestHandler {
    let session = NSURLSession()
    func sendRequest(url: String, method: String, params: [String: AnyObject],
        completionHandler handler: (NSData?, NSURLResponse?, NSError?) -> Void) {
            let paramString = params.stringFromHttpParameters()
            let requestUrl = NSURL(string:"\(url)?\(paramString)")
            //print requestUrl
            let request = NSMutableURLRequest(URL: requestUrl!)
            request.HTTPMethod = method
            
            session.dataTaskWithRequest(request, completionHandler: handler)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: handler)
    }
    
}

extension String {
    
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    ///
    /// This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// - returns: Return precent escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// - returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}