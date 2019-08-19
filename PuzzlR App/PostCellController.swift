//
//  PostCellController.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 6/30/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import UIKit

class PostCellController: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postStatsLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var post: Posts! {
        
        didSet {
            
            self.updateUI()
            
        }
        
    }
    
    func updateUI() {
        
        profileImageView.image = post.createdBy.profileImage
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0
        profileImageView.layer.masksToBounds = true
        nameLabel.text = post.createdBy.username
        timeAgoLabel.text = post.timeAgo
        postImageView.image = post.postImage
        postStatsLabel.text = "\(post.numberOfGoing!) going     \(post.numberOfComments!) comments     \(post.numberOfShares!)     shares"
        
    }
    
}
