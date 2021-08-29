//
//  NetworkLayer.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    let manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 30
        return Alamofire.Session(
            configuration: configuration
        )
    }()
    
    func makeGetRequest(_ apiType : String, parameters : [String : AnyObject]?, completionHandler: @escaping (_ responseObject: JSON?, _ error: NSError?) -> Void) {
        let completeUrl = apiType
        manager.request(completeUrl, method: .get, parameters: parameters, headers:nil).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value) as JSON
                completionHandler(json, nil)
            case .failure:
                completionHandler(nil, NSError())
            }
        }
    }
}
