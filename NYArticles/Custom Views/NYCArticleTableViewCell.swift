//
//  NYCArticleTableViewCell.swift
//  NYArticles
//
//  Created by Hem Sharma on 04/07/18.
//  Copyright © 2018 Hem Sharma. All rights reserved.
//

import UIKit

class NYCArticleTableViewCell: UITableViewCell
{
    @IBOutlet var titleField : UILabel!
    @IBOutlet var subTitleField : UILabel!
    @IBOutlet var dateField : UILabel!
    @IBOutlet var thumbnailView : UIImageView!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
