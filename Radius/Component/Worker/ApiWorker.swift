//
//  ApiWorker.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import Foundation
import UIKit

class Worker {
    /// This func is used to call API from networkLayer and give response and error
    /// - Parameter completionHandler: completion handler will return after async call
    /// - Returns: data in form of getRadiusList or NSError
    class func getRadiusList(_ url : String ,completionHandler: @escaping (_ response: RadiusModel?,_ error: NSError?) -> Void) {
        NetworkManager.sharedInstance.makeGetRequest(url, parameters: nil, completionHandler: {(response, error) in
            var resposeError: NSError?
            var successData : RadiusModel?
            if let error = error {
                resposeError = error as NSError
            }
            if error == nil {
                do {
                    if let responceToRawData =  try response?.rawData() {
                        successData = try JSONDecoder().decode(RadiusModel.self, from: responceToRawData)
                        guard let facility = successData?.facilities else { return }
                        guard let exclusions = successData?.exclusions else { return}
                        CoreDataRepository.deleteall(EntityName.options)
                        CoreDataRepository.deleteall(EntityName.exclusions)
                        CoreDataRepository.deleteall(EntityName.facilities)
                        facility.forEach { (facility) in
                            CoreDataRepository.createFacility(facility: facility)
                        }
                        exclusions.forEach { (exclusion) in
                            exclusion.forEach { (innetExclusion) in
                                CoreDataRepository.createExclusion(exclusion: innetExclusion)
                            }
                        }
                    }
                } catch let error {
                    resposeError = error as NSError
                }
            }
            completionHandler(successData, resposeError)
        })
    }
}
