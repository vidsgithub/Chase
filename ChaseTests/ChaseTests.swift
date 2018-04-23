//
//  ChaseTests.swift
//  ChaseTests
//
//  Created by Shingade on 4/19/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import XCTest
@testable import Chase

class ChaseTests: XCTestCase {
    var schoolModel:[Any]?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func loadResourcesFromFile() -> Data? {
        let bundle = Bundle.main
        let path = bundle.path(forResource: "school", ofType: "json")
        if let path = path {
            do {
                let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path), options: Data.ReadingOptions.alwaysMapped)
                return (data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func loadSATResourceFromFile() -> Data? {
        let path = Bundle.main.path(forResource: "sat", ofType: ".json")
        if let path = path {
            do {
                let data = try Data.init(contentsOf: URL.init(fileURLWithPath: path), options: Data.ReadingOptions.alwaysMapped)
                return (data)
            } catch let error {
                print(error)
            }
        }
        return nil
    }
    
    func testStudentJson() {
        if let data = self.loadResourcesFromFile() {
            API.shared.parseData(data: data, onSuccess: { (arraySchoolModel) in
                XCTAssertNotNil(arraySchoolModel, "unable to convert json to school model")
            }) { (error) in
                XCTAssert((error != nil) ? true : false, "Error in json")
            }
        }
    }
    
    func testStudentSATJson() {
        if let schoolSAT = self.loadSATResourceFromFile() {
            API.shared.parseSATData(data: schoolSAT, onSuccess: { (schoolSAT) in
                XCTAssertNotNil(schoolSAT, "Unable to parse DATA json")
            }, onFailure: { (error) in
                 XCTAssert((error != nil) ? true : false, "Error in json")
            })
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
