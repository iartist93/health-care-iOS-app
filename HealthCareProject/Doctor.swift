//
//  Doctor.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/5/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import Foundation
import CoreData

public class Doctor: NSManagedObject
{
    @NSManaged var name: String!
    @NSManaged var userName: String!
    @NSManaged var email: String!
    @NSManaged var password: String!
    @NSManaged var phoneNumber: String!
    @NSManaged var spectialziation: String!
    @NSManaged var location: String!
    @NSManaged var image: NSData!
}