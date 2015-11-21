//
//  DataHandler.swift
//  ShakeAuth
//
//  Created by Mike Wang on 11/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import Foundation
import Firebase

class DataHandler {
    static let root_url = "https://shakeauth.firebaseio.com"
    static let shakes_endpoint = "shakes"
    static let shook_key = "shook"
    
    static let firebaseRef = Firebase(url: root_url)
    static let shakesRef = Firebase(url: root_url).childByAppendingPath(shakes_endpoint)
    
    // Authenticate the user
    static func loginUser(email: String, password: String, completion: (NSError!, FAuthData!) -> Void) {
        firebaseRef.authUser(email, password: password, withCompletionBlock: completion)
    }
    
    // Submit a user shake
    // When a device is looking for a shake, there will be an entry for the uid in /shakes
    // If it the request exists, submitting a shake will set the "shook" field to true, otherwise does nothing
    static func submitShake(uid: String) {
        shakesRef.childByAppendingPath(uid).observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value != nil {
                shakesRef.childByAppendingPath(uid).childByAppendingPath(shook_key).setValue(true)
            }
        })
    }
    
    // Create a request to look for shakes
    static func submitShakeSearch(uid: String) {
        shakesRef.childByAppendingPath(uid).childByAppendingPath(shook_key).setValue(false)
    }
}