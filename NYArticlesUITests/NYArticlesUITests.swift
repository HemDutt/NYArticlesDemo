//
//  NYArticlesUITests.swift
//  NYArticlesUITests
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import XCTest

class NYArticlesUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp()
    {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample()
    {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testArticleTableInteraction()
    {        
        // Assert that we are displaying the tableview
        let articleTableView = app.tables["NYCArticleTableView"]
        XCTAssertTrue(articleTableView.exists, "Article tableview exists")
        
        
        // Get an array of cells
        let promise = expectation(description: "Wait for table cells")
        let tableCells = articleTableView.cells
        if tableCells.count > 0
        {
            promise.fulfill()
            // Grab the first cell and verify that it exists and tap it
            let tableCell = tableCells.element(boundBy: 0)
            XCTAssertTrue(tableCell.exists, "The cell exist on the table")
            
            // Does this actually take us to the next screen
            tableCell.tap()
            
            // Back
            app.navigationBars.buttons.element(boundBy: 0).tap()
            
            XCTAssertTrue(true, "Finished validating the table cells")
        }
        else
        {
            XCTAssert(false, "Was not able to find any table cells")
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
}
