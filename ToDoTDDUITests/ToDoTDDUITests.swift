//
//  ToDoTDDUITests.swift
//  ToDoTDDUITests
//
//  Created by Mac on 02.09.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import XCTest

class ToDoTDDUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.navigationBars["ToDoTDD.ItemListView"].buttons["Add"].tap()
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Meeting")
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("02/22/2016")
        let locationNameTextField = app.textFields["Location"]
        locationNameTextField.tap()
        locationNameTextField.typeText("Office")
        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        addressTextField.typeText("Infinite Loop 1, Cupertino")
        let descriptionTextField = app.textFields["Description"]
        descriptionTextField.tap()
        descriptionTextField.typeText("Bring iPad")
        app.buttons["Save"].tap()
        XCTAssertTrue(app.tables.staticTexts["Meeting"].exists)
        XCTAssertTrue(app.tables.staticTexts["02/22/2016"].exists)
        XCTAssertTrue(app.tables.staticTexts["Office"].exists)
    }
    
}
