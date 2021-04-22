//
//  MovieDetailUITests.swift
//  MovieAppUITests
//
//  Created by Chandan Singh on 20/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import XCTest

class MovieDetailUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNaviagationToDetailAndBack() {
        app.launch()
        sleep(4)
        app.collectionViews.cells.element(boundBy: 0).tap()
        app.buttons.element(boundBy: 0).tap()
    }
}
