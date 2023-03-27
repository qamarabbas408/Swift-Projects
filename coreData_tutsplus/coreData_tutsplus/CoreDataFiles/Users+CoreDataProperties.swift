//
//  Users+CoreDataProperties.swift
//  coreData_tutsplus
//
//  Created by Qamar Abbas on 21/02/2023.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var password: NSObject?
    @NSManaged public var email: NSObject?
    @NSManaged public var username: NSObject?

}

extension Users : Identifiable {

}
