//
//  NYCPopularArticleModel.swift
//  NYArticles
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import UIKit

class NYCPopularArticleModel: NSObject
{
    var storyURL : URL? = nil
    var mediaURL : URL? = nil

    var storyTitle : String? = nil
    var publishedDate : String? = nil
    var byLine : String? = nil
    
    override init()
    {
        super.init()
    }
    
    init(with dictionary : Dictionary <String , Any>)
    {
        if let title = dictionary["title"] as? String
        {
            self.storyTitle = title
        }
        if let storyurl = dictionary["url"] as? String
        {
            self.storyURL = URL.init(string: storyurl)
        }
        if let mediaArr = ((dictionary["media"] as? [Dictionary<String, Any>])?.first?["media-metadata"]) as?[Dictionary<String, Any>] , let mediaurl = mediaArr.first?["url"] as? String
        {
            self.mediaURL = URL.init(string: mediaurl)
        }
        if let date = dictionary["published_date"] as? String
        {
            self.publishedDate = date
        }
        if let by = dictionary["byline"] as? String
        {
            self.byLine = by
        }
    }
}
