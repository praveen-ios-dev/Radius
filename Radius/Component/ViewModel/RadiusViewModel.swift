//
//  RadiusViewModel.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import UIKit

protocol SelectionProtocol :class{
    func updateCell()
}

class RadiusViewModel {
    var model : RadiusModel?
    var exclusionDic : [String : String] = [:]
    weak var radiusDelegate : SelectionProtocol?
    
    /// init coreData and fetch value from Coredata
    required init() {
        self.model = CoreDataRepository.getModelData()
        getExclusionsDic()
    }
    
    /// func will return number of section default value is 0
    /// - Returns: totla number of section
    func numberOfSection()->Int{
        if let numberOfSection = model?.facilities?.count {
            return numberOfSection
        }
        return Int.zero
    }
    
    /// - Parameter indexPath: IindexPath is needed to get section header
    /// - Returns: section header text
    func getHeaderText(_ indexPath : IndexPath)->String{
        if let name =  model?.facilities?[indexPath.section].name{
            return name
        }
        return emptyString
    }
    
    /// - Parameter section: section is needed to get count
    /// - Returns: number of rows in a sections
    func getNumberOfRows(_ section : Int)->Int {
        if let numberOfRows = model?.facilities?[section].options?.count{
            return numberOfRows
        }
        return Int.zero
    }
    
    /// This will return options object to load data in cell
    /// - Parameter indexPath: is required to get option from list of Options
    /// - Returns: OptionObj to load cell
    func getOptionsObj(_ indexPath : IndexPath)->Option?{
        if let option = model?.facilities?[indexPath.section].options?[indexPath.row]{
            return option
        }
        return nil
    }
    
    /// This function will dump Exclusion data into globel dictionary
    private func getExclusionsDic(){
        var returnDic : [String:String] = [:]
        if let exclusions =  model?.exclusions?.first{
            var key = emptyString
            var value = emptyString
            exclusions.forEach { (exclusion) in
                if let option_id = exclusion.options_id{
                    if key.isEmpty{
                        key = option_id
                    }else{
                        value = option_id
                    }
                    if !value.isEmpty && !key.isEmpty{
                        returnDic[key] = value
                        key = emptyString
                        value = emptyString
                    }
                }
            }
        }
        exclusionDic = returnDic
    }
    
    /// This is the main func to enable and disable cell
    /// - Parameter indexPath: indexPath is needed for set cell value
    func selectLogic(_ indexPath : IndexPath){
        if let options = model?.facilities?[indexPath.section].options{
            for option in 0..<options.count{
                options[option].isSelected = false
            }
            options[indexPath.row].isSelected = true
        }
        disabledOptions(indexPath)
        radiusDelegate?.updateCell()
    }
    
    /// function will handle disabling and selectiion as per user selection
    /// - Parameter indexPath: indexPath is needed for set cell value
    private func disabledOptions(_ indexPath : IndexPath){
        var selectedKey = emptyString
        if let key = model?.facilities?[indexPath.section].options?[indexPath.row].id{
            selectedKey = exclusionDic[key].optionalValue
        }
        if let facilitys = model?.facilities{
            for indexValue in (indexPath.section+1)..<(facilitys.count){
                if let options = facilitys[indexValue].options{
                    for innerIndexValue in 0...(options.count-1){
                        options[innerIndexValue].isSelected = false
                        if options[innerIndexValue].id == selectedKey{
                            options[innerIndexValue].isEnabled = false
                        }else{
                            options[innerIndexValue].isEnabled = true
                        }
                    }
                }
            }
        }
    }
    
    /// Gives section header as string
    /// - Parameter section: section is required to get sectiion header
    /// - Returns: strings as section header
    func getHeaderText(_ section : Int)-> String{
        if let headerName = model?.facilities?[section].name{
            return headerName
        }
        return emptyString
    }
    
    func getModel()->RadiusModel?{
        if let model = model{
            return model
        }
        return nil
    }
}
