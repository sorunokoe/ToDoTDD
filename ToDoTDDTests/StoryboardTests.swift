//
//  StoryboardTests.swift
//  ToDoTDDTests
//
//  Created by Mac on 01.09.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import XCTest
@testable import ToDoTDD

class StoryboardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    func testInitialViewController_IsItemListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers[0]
        XCTAssertTrue(rootViewController is ItemListViewController)
    }
}
