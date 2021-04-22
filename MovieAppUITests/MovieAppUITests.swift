//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by Chandan Singh on 20/04/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import XCTest

class MovieAppUITests: XCTestCase {
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

    func testIsMovieListAvailable() {
        app.launch()
        sleep(4)
        let collectionCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertEqual(collectionCell.visible(), true)
    }
    
    func testErrorDisplayedForMovie() {
        app.launch()
        sleep(4)
        let trackErrorLabel = app.staticTexts["Label"]
        XCTAssertEqual(trackErrorLabel.exists, false)
    }
    
    func testMovieNavigationToDetailScreen() {
        app.launch()
        sleep(4)
        app.collectionViews.cells.element(boundBy: 0).tap()
    }
    
    func testMovieListScroll() {
        app.launch()
        sleep(4)
        let collectionView = app.collectionViews.element(boundBy: 0)
        let lastCell = collectionView.cells.element(boundBy: collectionView.cells.count - 1)
        collectionView.scrollToElement(element: lastCell)
    }
}

extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
