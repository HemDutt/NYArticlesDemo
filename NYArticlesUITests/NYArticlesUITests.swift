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

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testArticleTableInteraction()
    {
        app.launch()
        
        // Assert that we are displaying the tableview
        let articleTableView = app.tables["NYCArticleTableView"]
        XCTAssertTrue(articleTableView.exists, "Article tableview exists")
    }
    
}
