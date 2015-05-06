//
//  DocotorRegisterViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/5/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import Parse
import CoreData

class DocotorRegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userRoleSegment: UISegmentedControl!
    
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    
    var doctor: Doctor!
    var userRole: String = "Patient"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.activityIndicator)
    }

    @IBAction func signupAction(sender: AnyObject)
    {
        var username = self.usernameField.text
        var password = self.passwordField.text
        var email = self.emailField.text
        
        if username.utf16Count < 4 || password.utf16Count < 5 {
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 4 and password must be greater than 5", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        } else if emailField.text.utf16Count < 8 {
            var alert = UIAlertView(title: "Invalid", message: "Email must be greater than 8", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        } else {
            self.activityIndicator.startAnimating()
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            newUser.setObject(userRole, forKey: "role")
            
            newUser.signUpInBackgroundWithBlock({ (suceed, error) -> Void in
                self.activityIndicator.stopAnimating()
                if error != nil {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
            //self.saveInCoreData(username, email: email, password: password)
            //self.saveInUserDefault(username)
            self.performSegueWithIdentifier("showDoctorsTableView", sender: self)
        }
    }

    //Instance Mehtods 
    
    func saveInCoreData(userName: String, email: String, password: String)
    {
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            
            doctor = NSEntityDescription.insertNewObjectForEntityForName("Doctor", inManagedObjectContext: managedObjectContext) as Doctor
            
            doctor.userName = userName
            doctor.email = email
            doctor.password = password

            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)")
                return
            }
        }
    }

    
    func saveInUserDefault(userName: String) {
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "doctorUserName")
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: "isDoctorLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //Mark: Actions
    @IBAction func userRoleChanged(sender: AnyObject)
    {
        let index = sender.selectedSegmentIndex
        userRole = sender.titleForSegmentAtIndex(index)!
    }
}