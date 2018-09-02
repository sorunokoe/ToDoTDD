//
//  ToDoItemTests.swift
//  ToDoTDDTests
//
//  Created by Mac on 28.08.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import XCTest
@testable import ToDoTDD
import CoreLocation

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit_ShouldTakeTitle(){
        let item = ToDoItem(title: "Test title")
        XCTAssertEqual(item.title, "Test title")
    }
    func testInit_ShouldTakeTitleAndDescription() {
        let item = ToDoItem(title: "Test title", description: "Test description")
        XCTAssertEqual(item.itemDescription, "Test description")
    }
    func testInit_ShouldSetTitleAndDescriptionAndTimestamp() {
        let item = ToDoItem(title: "Test title",
                            description: "Test description",
                            timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp,
                       "Initializer should set the timestamp")
    }
    func testInit_ShouldSetTitleAndDescriptionAndTimestampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title",
                            description: "Test description",
                            timestamp: 0.0,
                            location: location)
        XCTAssertEqual(location.name, item.location?.name,
                       "Initializer should set the location")
    }
    func testEqualItems_ShouldBeEqual() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func testWhenLocationDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 description: "First description",
                                 timestamp: 0.0,
                                 location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title",
                                  description: "First description",
                                  timestamp: 0.0,
                                  location: Location(name: "Office"))
        XCTAssertNotEqual(firstItem, secondItem)
    }
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        var firstItem = ToDoItem(title: "First title",
                                 description: "First description",
                                 timestamp: 0.0,
                                 location: nil)
        var secondItem = ToDoItem(title: "First title",
                                  description: "First description",
                                  timestamp: 0.0,
                                  location: Location(name: "Office"))
        
        XCTAssertNotEqual(firstItem, secondItem)
        
        firstItem = ToDoItem(title: "First title",
                             description: "First description",
                             timestamp: 0.0,
                             location: Location(name: "Home"))
        secondItem = ToDoItem(title: "First title",
                              description: "First description",
                              timestamp: 0.0,
                              location: nil)
        XCTAssertNotEqual(firstItem, secondItem)
    }
    func testWhenTimestampDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 description: "First description",
                                 timestamp: 1.0)
        let secondItem = ToDoItem(title: "First title",
                                  description: "First description",
                                  timestamp: 0.0)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    func testWhenDescriptionDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
                                 description: "First description")
        let secondItem = ToDoItem(title: "First title",
                                  description: "Second description")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    func testWhenTitleDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title")
        let secondItem = ToDoItem(title: "Second title")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    func test_HasPlistDictionaryProperty() {
        let item = ToDoItem(title: "First")
        let dictionary = item.plistDict
        XCTAssertNotNil(dictionary)
        XCTAssertTrue(dictionary is NSDictionary)
    }
    func test_CanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Home")
        let item = ToDoItem(title: "The Title",
                            description: "The Description",
                            timestamp: 1.0,
                            location: location)
        let dict = item.plistDict
        let recreatedItem = ToDoItem(dict: dict)
        XCTAssertEqual(item, recreatedItem)
    }
    func test_CanBeSerializedAndDeserialized() {
        let location = Location(name: "Home", coordinate: CLLocationCoordinate2DMake(50.0, 6.0))
        let dict = location.plistDict
        XCTAssertNotNil(dict)
        let recreatedLocation = Location(dict: dict)
    }

}
