//
//  NYArticlesTests.swift
//  NYArticlesTests
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import XCTest

class NYArticlesTests: XCTestCase
{
    fileprivate var popularArticleVM = NYCPopularArticleViewModel()

    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchArticles()
    {
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Fetch most popular NYC articles")
        let popularArticleVM = NYCPopularArticleViewModel.init()
        popularArticleVM.getMostPopularArticlesFromNYC { (articles, unableToFetch) in
            // Make sure we downloaded some data.
            XCTAssertFalse(unableToFetch, "Unable to fetch data.")
            
            // Fulfilled expectation. background task has finished successfully.
            expectation.fulfill()
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchArticleDetails()
    {
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Fetch detail of a NYC article")
        let articleDetailVM = NYCNewsDetailViewModel.init()
        
        let article = NYCPopularArticleModel()
        article.storyURL = URL.init(string: "https://www.nytimes.com/2018/06/28/us/politics/trump-anthony-kennedy-retirement.html")
        
        articleDetailVM.getArticleDetails(from: article.storyURL!) { (htmlString, error) in
            
            XCTAssertNotNil(htmlString, "unable to fetch details of article")
            expectation.fulfill()
        }
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceExample()
    {
        // This is an example of a performance test case.
        self.measure{
            // Put the code you want to measure the time of here.
        }
    }
    
}
