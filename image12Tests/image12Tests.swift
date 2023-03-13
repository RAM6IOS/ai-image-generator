//
//  image12Tests.swift
//  image12Tests
//
//  Created by Bouchedoub Ramzi on 7/3/2023.
//

import XCTest
import UIKit
import CoreImage
@testable import image12

final class image12Tests: XCTestCase {
    var myTestClass: FilterViewModel!
    var loadImageCallCount = 0
    var testImage: UIImage?
    override func setUp() {
            super.setUp()
            myTestClass = FilterViewModel()
          testImage = UIImage(named: "test_image")
        
        }

    override func tearDown() {
        testImage = nil
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
    func testLoadImage() {
        // Create a test image.
        let testImage = UIImage(named: "artificial-intelligence")
        let myFilter = CIFilter.sepiaTone()

        myTestClass.image = testImage

        myTestClass.currentFilter = myFilter
        // Call the loadImage() function to load the test image and apply a filter to it.
        myTestClass.loadImage()

        // Assert that the outputImage variable of the filter is not nil.
        XCTAssertNotNil(myTestClass.currentFilter.outputImage, "outputImage should not be nil")

        
    }
    func testSetFilter() {
            let sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter?.setValue(CIImage(image: (testImage ?? UIImage(named: "artificial-intelligence"))!), forKey: kCIInputImageKey)
            
            let invertFilter = CIFilter(name: "CIColorInvert")
        invertFilter?.setValue(CIImage(image: (testImage ?? UIImage(named: "artificial-intelligence"))!), forKey: kCIInputImageKey)
            
        myTestClass.setFilter(sepiaFilter!)
            XCTAssertEqual(myTestClass.currentFilter, sepiaFilter!)
            
        myTestClass.setFilter(invertFilter!)
            XCTAssertEqual(myTestClass.currentFilter, invertFilter!)
        }
    
    
    func testApplyProcessing() {
            // Set up the input image, filter, and intensity
            let inputImage = UIImage(named: "inputImage")
            let filter = CIFilter(name: "CISepiaTone")
            let intensity: CGFloat = 0.5
            
            // Set the input image and current filter in the view model
        myTestClass.image = inputImage
        myTestClass.currentFilter = filter!
        myTestClass.filterIntensity = intensity
        

            
            // Call the applyProcessing() function
        myTestClass.applyProcessing()
            
            XCTAssertEqual(myTestClass.image?.size, UIImage(named: "inputImage")?.size, "Input and output images have different sizes")
        }
    
   

}
