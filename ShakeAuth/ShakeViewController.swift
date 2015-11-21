//
//  ViewController.swift
//  ShakeAuth
//
//  Created by Mike Wang on 11/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit
import SnapKit
import CoreMotion

class ShakeViewController: UIViewController {
//    @IBOutlet weak var xlabel: UILabel!
//    @IBOutlet weak var ylabel: UILabel!
//    @IBOutlet weak var zlabel: UILabel!
    @IBOutlet weak var phoneImage: UIImageView!
    
    var motionManager = CMMotionManager()
    
    // Recevied a shake notification
    func handleShake(notification: NSNotification) {
        // Animate shake
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( CATransform3D:CATransform3DMakeTranslation(-5, 0, 0 ) ),
            NSValue( CATransform3D:CATransform3DMakeTranslation( 5, 0, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 7/100
        phoneImage.layer.addAnimation( anim, forKey:nil )
        
        phoneImage.image = UIImage(named: "phoneshake_green")
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "endShake:", userInfo: nil, repeats: false)
        
        // Submit shake
        let uid = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        if uid != nil {
            print("Submitting shake for \(uid!)!")
            DataHandler.submitShake(uid!)
        } else {
            print("No user logged in!")
        }
    }
    
    func endShake(sender: NSTimer) {
        phoneImage.image = UIImage(named: "phoneshake")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIConstants.whiteColor

        // Add a shake notification observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleShake:", name: "shake", object: nil)
        
        // if debug, automatically add a shake request
        if AppDelegate.debug {
            let uid = NSUserDefaults.standardUserDefaults().stringForKey("uid")
            if uid != nil {
                DataHandler.submitShakeSearch(uid!)
            }
        }
        
//        if motionManager.accelerometerAvailable {
//            motionManager.accelerometerUpdateInterval = 0.1
//            
//            let queue = NSOperationQueue.mainQueue()
//
//            if self.motionManager.accelerometerData != nil {
//                motionManager.startAccelerometerUpdatesToQueue(queue) { (data, error) in
//                    self.xlabel.text = "X: " + String(data?.acceleration.x)
//                    self.ylabel.text = "Y: " + String(data?.acceleration.y)
//                    self.zlabel.text = "Z: " + String(data?.acceleration.z)
//                }
//            }
//        }
    }

    // Motion events
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        self.becomeFirstResponder()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake {
            // Register motion notification
            NSNotificationCenter.defaultCenter().postNotificationName("shake", object: self)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

