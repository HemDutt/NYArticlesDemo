//
//  Constants.swift
//  NYArticles
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import Foundation

let NYCMostPopularArticleURL = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=54e5496eb75443aea29abca3eda6dbf6"

enum ApiResponseType : Int
{
    case json
    case html
}
