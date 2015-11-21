//
//  LoginViewController.swift
//  ShakeAuth
//
//  Created by Mike Wang on 11/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    let logoView = UIImageView()
    let titleView = UILabel()
    let backgroundImageView = UIImageView()
    
    let emailField = UITextField()
    let passwordField = UITextField()
    let signinbutton = UIButton(type: UIButtonType.System) as UIButton
    let errorText = UILabel()
    let errorView = UIView()

    // Login the user to firebase
    func loginUser(sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        DataHandler.loginUser(email, password: password, completion: { (error, authData) in
            // We are now logged in
            let email = authData.providerData["email"]
            print("Logged in with email \(email!) and id \(authData.uid)")
            
            // Save user id
            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKeyPath: "uid")
            
            // Present shake view controller
            let shakeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("shakeVC")
            self.presentViewController(shakeVC, animated: true, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    // Build the UI
    func createView() {
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(backgroundImageView)
        view.addSubview(logoView)
        view.addSubview(titleView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signinbutton)
        view.addSubview(errorText)
        view.addSubview(errorView)
        
        // Set the background image
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        //        backgroundImageView.image = UIImage(named: "background2.png")!
        backgroundImageView.alpha = 0.5
        backgroundImageView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(view.snp_center)
            make.size.equalTo(view.snp_size)
        }
        
        // Logo and title
        logoView.contentMode = UIViewContentMode.ScaleAspectFit
        logoView.image = UIImage(named: "phoneshake.png")
        logoView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(view.snp_top).offset(UIConstants.spacing3)
            make.height.equalTo(UIConstants.logoSizeMed)
            make.width.equalTo(UIConstants.logoSizeMed)
        }
        formatLabel(titleView, text: "ShakeAuth", color: UIConstants.primaryColor, font: UIConstants.titleFont)
        titleView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(logoView.snp_bottom).offset(UIConstants.spacing1)
            make.centerX.equalTo(view.snp_centerX)
        }
        
        // Email field
        emailField.textColor = UIConstants.darkGrayColor
        emailField.tintColor = UIConstants.primaryColor
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName:UIConstants.lightGrayColor])
        emailField.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleView.snp_bottom).offset(UIConstants.spacing2)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(view.snp_width).multipliedBy(UIConstants.fieldWidthProp)
        }
        
        // Password field
        passwordField.textColor = UIConstants.darkGrayColor
        passwordField.tintColor = UIConstants.primaryColor
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:UIConstants.lightGrayColor])
        passwordField.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(emailField.snp_bottom).offset(UIConstants.spacing1)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(view.snp_width).multipliedBy(UIConstants.fieldWidthProp)
        }
        passwordField.secureTextEntry = true
        
        // Signin button
        signinbutton.setTitle("Sign In", forState: .Normal)
        signinbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signinbutton.backgroundColor = UIConstants.primaryColor
        signinbutton.layer.cornerRadius = 5
        signinbutton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(passwordField.snp_bottom).offset(UIConstants.spacing1)
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(view.snp_width).multipliedBy(UIConstants.fieldWidthProp)
        }
        signinbutton.addTarget(self, action: "loginUser:", forControlEvents: UIControlEvents.TouchUpInside)
        
        emailField.text = "mzw4@cornell.edu"
        passwordField.text = "123"
    }
    
    func error(msg: String) {
        // show error message
        errorText.text = msg
        UIView.animateWithDuration(0.2, animations: {
            self.errorView.alpha = 1
        })
    }
    
    override func viewDidLayoutSubviews() {
        // Add lines for fields
        createLinedField(emailField)
        createLinedField(passwordField)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
