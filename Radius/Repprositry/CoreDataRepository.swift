//
//  FacilityReprositry.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import Foundation

class CoreDataRepository{
    
    static func createFacility(facility: Facility) {
        let CDFacility = CDFacilities(context: PersistentStorage.shared.context)
        CDFacility.facility_id = facility.facility_id
        CDFacility.name = facility.name
        var optionsSet = Set<CDOptions>()
        facility.options?.forEach({ (option) in
            let cdOpions = CDOptions(context: PersistentStorage.shared.context)
            cdOpions.icon = option.icon
            cdOpions.id = option.id
            cdOpions.name = option.name
            cdOpions.isSelected = false
            cdOpions.isEnabled = true
            optionsSet.insert(cdOpions)
        })
        CDFacility.toOptions = optionsSet
        PersistentStorage.shared.saveContext()
    }
    
    static func createExclusion(exclusion: Exclusion) {
        let cdExclusions = CDExclusions(context:PersistentStorage.shared.context)
        cdExclusions.facility_id = exclusion.facility_id
        cdExclusions.options_id = exclusion.options_id
        PersistentStorage.shared.saveContext()
    }
    
    static func getAllFacility() -> [Facility]?{
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CDFacilities.fetchRequest()) as? [CDFacilities] else { return nil }
            var facilities : [Facility] = []
            result.forEach { (CDFacilities) in
                var optionlocal : [Option] = []
                CDFacilities.toOptions?.forEach({ (option) in
                    let optionObj = Option(name: option.name, icon: option.icon, id: option.id, isSelected: option.isSelected, isEnabled: option.isEnabled)
                    optionlocal.append(optionObj)
                })
                let facility = Facility(facilityID: CDFacilities.facility_id, name: CDFacilities.name, options: optionlocal)
                facilities.append(facility)
            }
            return facilities
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    static func getAllExclusion()->[Exclusion]?{
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CDExclusions.fetchRequest()) as? [CDExclusions] else { return nil }
            var exclusions : [Exclusion] = []
            result.forEach { (cDExclusion) in
                let exclusion = Exclusion(facility_id: cDExclusion.facility_id, options_id: cDExclusion.options_id)
                exclusions.append(exclusion)
            }
            return exclusions
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    static func getModelData()->RadiusModel?{
        var exclusion : [[Exclusion]] = []
        exclusion.append(getAllExclusion()!)
        return RadiusModel(facilities: getAllFacility(), exclusions: exclusion)
    }
    
    static func deleteall(_ entityName : String) {
        PersistentStorage.shared.delete(entityName: entityName)
        PersistentStorage.shared.saveContext()
    }
    
    
}
