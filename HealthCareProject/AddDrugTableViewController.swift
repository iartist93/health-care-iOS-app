//
//  AddDrugTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/4/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import CoreData

class AddDrugTableViewController: UITableViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var noOfCapsField: UITextField!
    @IBOutlet weak var noPerDayField: UITextField!
    @IBOutlet weak var scientificNameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var otherNotesField: UITextField!
    
    var drug: Drug!
    
    @IBAction func save()
    {
        var errorField = ""
        if nameField.text == "" {
            errorField = "name"
        }
        else if descriptionField.text == "" {
            errorField = "description"
        }
        else if noOfCapsField.text == "" {
            errorField = "number of caps"
        }
        else if noPerDayField.text == "" {
            errorField = "number of caps per day"
        }
        else if scientificNameField.text == "" {
            errorField = "scientific name"
        }
        else if priceField.text == "" {
            errorField = "price"
        }
        else if companyField.text == "" {
            errorField = "company name"
        }
        else if otherNotesField.text == "" {
            errorField = "other notes field"
        }
        
        if errorField != "" {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the drug " + errorField + ". All fields are mandatory.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true, completion: nil)
         
            return  // Return .. don't process the reset of code
        }
        
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            
            drug = NSEntityDescription.insertNewObjectForEntityForName("Drug", inManagedObjectContext: managedObjectContext) as Drug
            
            drug.name = nameField.text
            drug.desciption = descriptionField.text
            drug.scientificName = scientificNameField.text
            drug.cc_by = companyField.text
            drug.notes = otherNotesField.text
            drug.price = NSNumberFormatter().numberFromString(priceField.text)
            drug.numberOfCaps = NSNumberFormatter().numberFromString(noOfCapsField.text)
            drug.numberOfTimesPerDay = NSNumberFormatter().numberFromString(noPerDayField.text)

            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)")
                return
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
