//
//  image12Tests.swift
//  image12Tests
//
//  Created by Bouchedoub Ramzi on 7/3/2023.
//

import XCTest
@testable import image12

final class image12Tests: XCTestCase {
    var myTestClass: FilterViewModel!
    override func setUp() {
            super.setUp()
            myTestClass = FilterViewModel()
        }

    

    override func tearDown() {
        
    }

    func testExample() throws {
        //Given
        myTestClass.image = UIImage(named: "artificial-intelligence")
        //when
        myTestClass.nillimage()
        //Then
        XCTAssertNil(myTestClass.image, "image should be nil")

    }
    func testWriteToPhotoAlbum() {
        guard var testImage = UIImage(named: "testImage") else { return  }
        myTestClass.writeToPhotoAlbum(image: testImage)
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssert(true, "writeToPhotoAlbum() function was called without errors.")
    }

   /* func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
