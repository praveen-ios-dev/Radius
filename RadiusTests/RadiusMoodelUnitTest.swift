//
//  RadiusMoodelUnitTest.swift
//  RadiusTests
//
//  Created by kumar praveen on 29/08/21.
//

import XCTest
@testable import Radius

class RadiusMoodelUnitTest: XCTestCase {
    let model = RadiusViewModel()
    
    func test_NumberOfSection_For_NotZero_Return_Success() {
        let numberOfSection = model.numberOfSection()
        XCTAssertNotNil(numberOfSection)
    }
    
    func test_CoreDataExclusion_For_Return_NonEmpty() {
        let coredata = CoreDataRepository.getAllExclusion()
        XCTAssertNotNil(coredata)
    }
    
    func test_CoreDatafacilities_For_Return_NonEmpty() {
        let coredata = CoreDataRepository.getAllFacility()
        XCTAssertNotNil(coredata)
    }
    
    func test_CoreDataModel_For_Return_NonEmpty() {
        let coredata = CoreDataRepository.getModelData()
        XCTAssertNotNil(coredata)
    }
    
    func test_Model_for_NotNill_Result_Success(){
        XCTAssertNotNil(model.getModel())
    }
    
    func test_ExclusionDic_For_NotNil_Return_NotNil(){
        XCTAssertNotNil(model.exclusionDic)
    }

}
