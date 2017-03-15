//
//  feedCell.swift
//  simstagram
//
//  Created by Simrandeep Singh on 3/15/17.
//  Copyright © 2017 Sim Singh. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class feedCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    @IBOutlet weak var contentImageView: PFImageView!
    
    var post: PFObject? {
        didSet{
            captionLabel.text = post?.value(forKey: "caption") as? String
            
            commentsCountLabel.text! = String(describing: post?.value(forKey: "commentsCount") as! Int)
            
            likesCountLabel.text = String(describing: post?.value(forKey: "likesCount") as! Int)
            
            let author = post?.value(forKey: "author") as? PFUser
            
            usernameLabel.text = author?.username
            
            timestampLabel.text = post?.value(forKey: "createdAtString") as? String
            
            contentImageView.file = post?.value(forKey: "media") as? PFFile
            self.contentImageView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
