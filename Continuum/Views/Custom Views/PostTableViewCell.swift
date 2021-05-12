//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions
    
    //MARK: - Functions
    func updateViews() {
        guard let post = post else { return }
        postImageView.image = post.photo
        captionLabel.text = post.caption
        commentsCountLabel.text = "Number of Comments: \(post.comments.count)"
    }
    
}//End of class
