//
//  RadiusModel.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import Foundation

// MARK: - RadiusModel
class RadiusModel: Codable {
    var facilities: [Facility]?
    var exclusions: [[Exclusion]]?
    init(facilities : [Facility]? , exclusions : [[Exclusion]]?) {
        self.facilities = facilities
        self.exclusions = exclusions
    }
}

// MARK: - Exclusion
class Exclusion: Codable {
    var facility_id, options_id: String?
    init(facility_id: String? , options_id : String?) {
        self.facility_id = facility_id
        self.options_id = options_id
    }
}

// MARK: - Facility
class Facility: Codable {
    var facility_id, name: String?
    var options: [Option]?

    init(facilityID : String? ,name : String?, options : [Option]){
        self.facility_id = facilityID
        self.name = name
        self.options = options
    }
}

// MARK: - Option
class Option: Codable {
    var name, icon, id: String?
    var isSelected : Bool? = false
    var isEnabled : Bool? = true
    init(name: String?, icon:String?, id : String?,isSelected : Bool? ,isEnabled : Bool?) {
        self.name = name
        self.id = id
        self.icon = icon
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }
}
