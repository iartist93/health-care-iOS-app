//
//  myRemiandersTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/20/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import CoreData

class myRemiandersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchedResultController: NSFetchedResultsController!
    
    var myList: [ListItem] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Polish the tableView UI
        tableView.backgroundColor =  UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0,alpha: 1)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        //tableView.tableFooterView = UIView(frame: CGRectZero)  // Remove the footer with blank view
        
        // Fetching the data from CoreData
        var fetchRequest = NSFetchRequest(entityName: "ListItem")
        var sortDescriptor = NSSortDescriptor(key: "drugName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        {
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultController.delegate = self
            var e: NSError?
            var result = fetchedResultController.performFetch(&e)
            myList = fetchedResultController.fetchedObjects as! [ListItem]
            if result != true
            {
                println(e!.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myList.count
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
//        
//        let listItem = myList[indexPath.row]
//        println(listItem.drugName)
//
//        cell.textLabel?.text = listItem.drugName
//        // cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18.0)

        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Acephen"
        case 1:
            cell.textLabel?.text = "Acephen"
        case 2:
            cell.textLabel?.text = "Acephen"
        default :
            break
        }
        
        
        
        return cell
    }
    
    //MARK: NSFetchResultCotroller Delegate Methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        myList = controller.fetchedObjects as! [ListItem]
        
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
            
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    
    
    
    
    
    
}
