//
//  AlbertsonCodingAssignmentTests.swift
//  AlbertsonCodingAssignmentTests
//
//  Created by Samuel Adama on 1/25/23.
//

import XCTest
@testable import AlbertsonCodingAssignment

final class AlbertsonCodingAssignmentTests: XCTestCase {

    var vm: CatViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        vm = CatViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
        try super.tearDownWithError()
    }

    func testDownloadingFacts() {
        let expectation = expectation(description: "Cat Facts Download")
        
        vm?.loadFacts(completion: { fact in
            XCTAssertNotNil(fact.data.first, "The fact should not be nil or empty.")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadingFactsFailure() {
        
        vm?.loadFacts(url: "https://jhjh", completion: { fact in
            XCTAssertNil(fact.data.first, "This should be nil or empty.")
            XCTAssertThrowsError(fact.data)
        })
    }
    
    func testDownloadingCatImage() {
        let expectation = expectation(description: "Cat Image Download")
        
        vm?.downloadImage(completion: { image in
            XCTAssertNotNil(image, "The image should not be nil")
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadingCatImageFailure() {
        vm?.loadFacts(url: "https://jhjh", completion: { image in
            XCTAssertNil(image, "This should be nil or empty.")
            XCTAssertThrowsError(image)
        })
    }
}
