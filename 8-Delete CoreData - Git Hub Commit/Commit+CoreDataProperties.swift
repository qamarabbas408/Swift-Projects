//
//  Commit+CoreDataProperties.swift
//  GitHub Commits _ CoreData
//
//  Created by Qamar Abbas on 15/02/2023.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var date: Date
    @NSManaged public var sha: String
    @NSManaged public var message: String
    @NSManaged public var url: String
    @NSManaged public var author: Author

}

extension Commit : Identifiable {

}
