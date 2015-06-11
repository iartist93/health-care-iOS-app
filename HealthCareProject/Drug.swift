//
//  Drug.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/4/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import Foundation
import CoreData


public class Drug: NSManagedObject
{
    @NSManaged var name: String!
    @NSManaged var price: NSNumber!
    @NSManaged var desciption: String!
    @NSManaged var numberOfCaps: NSNumber!
    @NSManaged var numberOfTimesPerDay: NSNumber!
    @NSManaged var scientificName: String!
    @NSManaged var cc_by: String!
    @NSManaged var notes: String!
}
