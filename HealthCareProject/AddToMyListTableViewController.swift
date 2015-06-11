//
//  AddToMyListTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/5/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import CoreData

class AddToMyListTableViewController: UITableViewController {

    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var numberOfCapsPerDay: UILabel!
    @IBOutlet weak var snooze: UISwitch!
    
    
    var listItem: ListItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add To List"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Instance Methods
    @IBAction func save() {
        var drugName = self.navigationItem.title
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            
            listItem = NSEntityDescription.insertNewObjectForEntityForName("ListItem", inManagedObjectContext: managedObjectContext) as! ListItem
            listItem.drugName = drugName
            listItem.capsNumber = numberOfCapsPerDay.text?.toInt()
            listItem.startDate = startTime.date
            if snooze.on { listItem.snooze = 1 }
            else { listItem.snooze = 0 }
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)")
                return
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}