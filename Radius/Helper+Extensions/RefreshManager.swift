//
//  RefreshManager.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import Foundation

class RefreshManager {
    
    static let shared = RefreshManager()
    let defaults = UserDefaults.standard
    private let calender = Calendar.current
    
    private init() {}
    
    func loadDataIfNeeded(completion: (Bool) -> Void) {
        if isRefreshRequired() {
            defaults.set(Date(), forKey: UserDefaultKey.lastRefresh)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    private func isRefreshRequired(userPickedHour: Int = 16) -> Bool {
        guard let lastRefreshDate = defaults.object(forKey: UserDefaultKey.lastRefresh) as? Date else {
            return true
        }
        if let diff = calender.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour,
           let currentHour =  calender.dateComponents([.hour], from: Date()).hour,
           diff >= 24, userPickedHour <= currentHour {
            return true
        } else {
            return false
        }
    }
}
