//
//  RadiusRefreshManagerUnitTestCase.swift
//  RadiusTests
//
//  Created by kumar praveen on 29/08/21.
//

import XCTest
@testable import Radius

class RadiusRefreshManagerUnitTestCase: XCTestCase {
    
    func test_For_UserDefault_DataAvalible_Result_Success(){
        let Value = RefreshManager.shared.defaults.object(forKey: UserDefaultKey.lastRefresh)
        XCTAssertNotNil(Value)
    }
    
    func test_For_ifRefreshRequired_Result_Success(){
        RefreshManager.shared.loadDataIfNeeded { (value) in
            XCTAssertFalse(value)
        }
    }
    
}
