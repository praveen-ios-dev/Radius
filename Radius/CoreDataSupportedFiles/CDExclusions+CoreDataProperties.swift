//
//  CDExclusions+CoreDataProperties.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//
//

import Foundation
import CoreData


extension CDExclusions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExclusions> {
        return NSFetchRequest<CDExclusions>(entityName: EntityName.exclusions)
    }

    @NSManaged public var facility_id: String?
    @NSManaged public var options_id: String?

}

extension CDExclusions : Identifiable {

}
