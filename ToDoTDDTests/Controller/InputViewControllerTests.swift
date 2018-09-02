//
//  InputViewControllerTests.swift
//  ToDoTDDTests
//
//  Created by Mac on 29.08.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import XCTest
@testable import ToDoTDD
import CoreLocation

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func test_HasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }
    func test_HasDateTextField() {
        XCTAssertNotNil(sut.dateTextField)
    }
    func test_HasAdressTextField() {
        XCTAssertNotNil(sut.addressTextField)
    }
    func test_HasDescriptionTextField() {
        XCTAssertNotNil(sut.descriptionTextField)
    }
    func test_HasLocationTextField() {
        XCTAssertNotNil(sut.locationTextField)
    }
    func test_HasSaveButton() {
        XCTAssertNotNil(sut.saveButton)
    }
    func test_HasCancelButton() {
        XCTAssertNotNil(sut.cancelButton)
    }
//    func testSave_UsesGeocoderToGetCoordinateFromAddress() {
//        let mockInputViewController = MockInputViewController()
//        mockInputViewController.titleTextField = UITextField()
//        mockInputViewController.dateTextField = UITextField()
//        mockInputViewController.locationTextField = UITextField()
//        mockInputViewController.addressTextField = UITextField()
//        mockInputViewController.descriptionTextField = UITextField()
//        mockInputViewController.titleTextField.text = "Test Title"
//        mockInputViewController.dateTextField.text = "02/22/2016"
//        mockInputViewController.locationTextField.text = "Office"
//        mockInputViewController.addressTextField.text = "Infinite Loop 1, Cupertino"
//        mockInputViewController.descriptionTextField.text = "Test Description"
//        let mockGeocoder = MockGeocoder()
//        mockInputViewController.geocoder = mockGeocoder
//        mockInputViewController.itemManager = ItemManager()
//        let expect = expectation(description: "bla")
//        mockInputViewController.completionHandler = {
//            expect.fulfill()
//        }
//        mockInputViewController.save()
//        placemark = MockPlacemark()
//        let coordinate = CLLocationCoordinate2DMake(37.3316851,
//                                                    -122.0300674)
//        placemark.mockCoordinate = coordinate
//        mockGeocoder.completionHandler?([placemark], nil)
//        waitForExpectations(timeout: 1, handler: nil)
//        let item = mockInputViewController.itemManager?.itemAtIndex(0)
//        let testItem = ToDoItem(title: "Test Title",
//                                description: "Test Description",
//                                timestamp: 1456095600,
//                                location: Location(name: "Office", coordinate: coordinate))
//        XCTAssertEqual(item, testItem)
//    }
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail(); return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
    func test_GeocoderWorksAsExpected() {
        let expecta = expectation(description: "Wait for geocode")
        
        CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertin") {
            (placemarks, error) -> Void in
            let placemark = placemarks?.first
            
            let coordinate = placemark?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return
            }
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return
            }
            XCTAssertEqualWithAccuracy(latitude, 37.3316833,
                                       accuracy: 0.000001)
            XCTAssertEqualWithAccuracy(longitude, -122.0301031,
                                       accuracy: 0.000001)
            expecta.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    func testSave_DismissesViewController() {
        let mockInputViewController = MockInputViewController()
        mockInputViewController.titleTextField = UITextField()
        mockInputViewController.dateTextField = UITextField()
        mockInputViewController.locationTextField = UITextField()
        mockInputViewController.addressTextField = UITextField()
        mockInputViewController.descriptionTextField = UITextField()
        mockInputViewController.titleTextField.text = "Test Title"
        mockInputViewController.save()
        XCTAssertTrue(mockInputViewController.dismissGotCalled)
    }
}
extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        override func geocodeAddressString(_ addressString: String, in region: CLRegion?, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    class MockPlacemark : CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else
            { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude,
                              longitude: coordinate.longitude)
        }
    }
    class MockInputViewController : InputViewController {
        var dismissGotCalled = false
        var completionHandler: (() -> Void)?
        override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
            dismissGotCalled = true
            completionHandler?()
        }
    }
}
