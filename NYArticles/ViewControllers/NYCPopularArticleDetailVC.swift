//
//  DetailViewController.swift
//  NYArticles
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import UIKit

class NYCPopularArticleDetailVC: UIViewController {

    @IBOutlet weak var detailDescriptionView: UITextView!
    fileprivate var articleDetailVM = NYCNewsDetailViewModel()
    @IBOutlet weak var spinner : UIActivityIndicatorView!

    func configureViewWith(url : URL?)
    {
        // Update the user interface for the detail item.
        if let storyUrl = url
        {
            articleDetailVM.getArticleDetails(from: storyUrl) { (htmlString , error) in
                
                self.spinner.stopAnimating()
                if (error == nil)  && (htmlString != nil)
                {
                    self.detailDescriptionView.attributedText = htmlString
                }
                else
                {
                    self.detailDescriptionView.attributedText = NSAttributedString.init(string: "Unable to fetch story detail.")
                }
            }
        }
        else
        {
            self.spinner.stopAnimating()
            self.detailDescriptionView.attributedText = NSAttributedString.init(string: "Unable to fetch story detail.")
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spinner.startAnimating()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NYCPopularArticleModel?
    {
        didSet
        {
            // Update the view.
            configureViewWith(url : detailItem?.storyURL)
        }
    }
}

