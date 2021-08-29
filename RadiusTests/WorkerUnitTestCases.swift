//
//  WorkerUnitTestCases.swift
//  RadiusTests
//
//  Created by kumar praveen on 29/08/21.
//

import XCTest
@testable import Radius

class WorkerUnitTestCases: XCTestCase {
    
    func test_Worker_For_ValidURL_Result_Success(){
        Worker.getRadiusList(URL.assignmentAPI){(response, error) in
            XCTAssertNotNil(response)
        }
    }
    
    func test_Worker_For_Invalid_URL_Result_Fail(){
        Worker.getRadiusList("XYZ"){(response, error) in
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        }
    }

}
