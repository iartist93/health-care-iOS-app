//
//  DoctorLoginViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/5/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import Parse
import CoreData

class DoctorLoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    var retrivedDoctors: [Doctor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.activityIndicator)
    }
    
    //MARK: Action
    @IBAction func loginAction(sender: AnyObject)
    {
        // Custom Login implementation for parse
        var username = self.usernameField.text
        var password = self.passwordField.text
        
        // If the username and password length > 4
        if username.utf16Count < 4 || password.utf16Count < 5
        {
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and password must be greater than 5", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        }
        else
        {
            self.activityIndicator.startAnimating()
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                self.activityIndicator.stopAnimating()
                if user != nil {
                    NSUserDefaults.standardUserDefaults().setObject(username, forKey: "doctorUserName")
                    NSUserDefaults.standardUserDefaults().setObject(true, forKey: "isDoctorLoggedIn")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }
    
    //MARK: Segues
    @IBAction func close(segue: UIStoryboardSegue) {}
}
