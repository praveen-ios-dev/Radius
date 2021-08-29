//
//  CDFacilities+CoreDataProperties.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//
//

import Foundation
import CoreData


extension CDFacilities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFacilities> {
        return NSFetchRequest<CDFacilities>(entityName: EntityName.facilities)
    }

    @NSManaged public var facility_id: String?
    @NSManaged public var name: String?
    @NSManaged public var toOptions: Set<CDOptions>?

}

// MARK: Generated accessors for toOptions
extension CDFacilities {

    @objc(addToOptionsObject:)
    @NSManaged public func addToToOptions(_ value: CDOptions)

    @objc(removeToOptionsObject:)
    @NSManaged public func removeFromToOptions(_ value: CDOptions)

    @objc(addToOptions:)
    @NSManaged public func addToToOptions(_ values: Set<CDOptions>)

    @objc(removeToOptions:)
    @NSManaged public func removeFromToOptions(_ values: Set<CDOptions>)

}

extension CDFacilities : Identifiable {
}
