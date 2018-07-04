//
//  NYCNewsDetailViewModel.swift
//  NYArticles
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import UIKit

class NYCNewsDetailViewModel: NSObject
{
    func getArticleDetails(from url : URL, completionBlock : @escaping (NSAttributedString? , Error?) -> Void)
    {
        NetworkClient.sharedInstance.getDataFor(url: url, responseType: .html) { (response, error) in
            
            if error == nil
            {
                if let htmlString = response as? NSAttributedString
                {
                    completionBlock(htmlString, nil)
                }
                else
                {
                    completionBlock(nil, error)
                }
            }
            else
            {
                completionBlock(nil, error)
            }
        }
    }
}
