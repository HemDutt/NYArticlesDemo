//
//  NYCPopularArticleViewModel.swift
//  NYArticles
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import UIKit

class NYCPopularArticleViewModel: NSObject
{
    var popularArticlesArr = [NYCPopularArticleModel]()
    
    func getMostPopularArticlesFromNYC(completionBlock : @escaping (Array<NYCPopularArticleModel> , _ unableToFetchNewRecords : Bool) -> Void)
    {
        NetworkClient.sharedInstance.getDataFor(url: URL.init(string: NYCMostPopularArticleURL)!) { (response, error) in
         
            if error != nil
            {
                print(error?.code ?? "")
                //return old records with flag that new fetch failed
                completionBlock(self.popularArticlesArr, true)
            }
            else
            {
                if let articleArr = ((response as? Dictionary<String, Any>)?["results"]) as? [Dictionary<String, Any>]
                {
                    //Clean previous records
                    self.popularArticlesArr.removeAll(keepingCapacity: false)
                    for article in articleArr
                    {
                        let articleObj = NYCPopularArticleModel.init(with: article)
                        self.popularArticlesArr.append(articleObj)
                    }
                    
                    completionBlock(self.popularArticlesArr, false)
                }
                else
                {
                    //return old records with flag that new fetch failed
                    completionBlock(self.popularArticlesArr, true)
                }
            }
        }
    }
}
