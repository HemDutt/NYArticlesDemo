//
//  MasterViewController.swift
//  NYArticles
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class NYCPopularArticleVC: UITableViewController
{
    fileprivate var detailViewController: NYCPopularArticleDetailVC? = nil
    fileprivate var popularArticlesArr = [NYCPopularArticleModel]()
    fileprivate var popularArticleVM = NYCPopularArticleViewModel()


    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.tableFooterView = UIView()
        self.tableView.accessibilityIdentifier = "NYCArticleTableView"
        
        popularArticleVM.getMostPopularArticlesFromNYC { (popularArticles , unableToFetchNewRecords) in
            self.popularArticlesArr = popularArticles
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool)
    {
        //clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetail"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                if let controller = segue.destination as? NYCPopularArticleDetailVC
                {
                    let object = popularArticlesArr[indexPath.row]
                    controller.detailItem = object
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return popularArticlesArr.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 116.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "articleTableCell", for: indexPath) as? NYCArticleTableViewCell
        {
            let articleObject = popularArticlesArr[indexPath.row]
            cell.titleField.text = articleObject.storyTitle
            cell.accessoryType = .disclosureIndicator
            cell.thumbnailView?.sd_setImage(with: articleObject.mediaURL, placeholderImage: nil)
            cell.subTitleField.text = articleObject.byLine
            cell.dateField.text = articleObject.publishedDate
            return cell
        }

        return UITableViewCell.init()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

