//
//  ListItem.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/20/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import Foundation
import CoreData

public class ListItem: NSManagedObject
{
    @NSManaged var drugName: String!
    @NSManaged var startDate: NSDate!
    @NSManaged var snooze: NSNumber!
    @NSManaged var capsNumber: NSNumber!
}