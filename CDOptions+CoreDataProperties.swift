//
//  CDOptions+CoreDataProperties.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//
//

import Foundation
import CoreData


extension CDOptions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDOptions> {
        return NSFetchRequest<CDOptions>(entityName: EntityName.options)
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var isEnabled: Bool
    @NSManaged public var toFacilitys: CDFacilities?

}

extension CDOptions : Identifiable {

}
