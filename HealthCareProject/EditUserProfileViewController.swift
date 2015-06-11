//
//  EditUserProfileViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/7/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import Parse

class EditUserProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(self.activityIndicator)
        
        var currentUser = PFUser.currentUser()!
        emailField.text = currentUser.email
        
        let firstName = currentUser.objectForKey("firstname") as? String
        let lastName = currentUser.objectForKey("lastname") as? String
        let phoneNumber = currentUser.objectForKey("phoneNumber") as? String
        let location = currentUser.objectForKey("location") as? String
        
        println("\(firstName) + \(lastName) + \(phoneNumber) + \(location)")
        
        if firstName != nil {
            firstnameField.text = firstName
        }
        
        if lastName != nil {
            lastnameField.text = lastName
        }
        
        if phoneNumber != nil {
            phoneNumberField.text = phoneNumber
        }
        
        if location != nil {
            locationField.text = location
        }
    }
    
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        //TODO: Check whether a filed has a value or not, if has ANY value then the user tried to fill this field, then check if this field is valid or not, set the currentUser object
        
        self.activityIndicator.startAnimating()
        var currentUser = PFUser.currentUser()!
        currentUser.setObject(firstnameField.text, forKey: "firstname")
        currentUser.setObject(lastnameField.text, forKey: "lastname")
        currentUser.setObject(emailField.text, forKey: "email")
        currentUser.setObject(phoneNumberField.text, forKey: "phoneNumber")
        currentUser.setObject(locationField.text, forKey: "location")
        
        
        currentUser.saveInBackgroundWithBlock({ (suceed, error) -> Void in
            
            self.activityIndicator.stopAnimating()
            
            if error != nil {
                var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            } else { println("Data savvvvvvvvvved!!!!!1") }
        })
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
