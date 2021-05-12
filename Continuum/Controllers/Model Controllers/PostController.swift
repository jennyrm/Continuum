//
//  PostController.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostController {
    //MARK: - Properties
    ///singleton
    static let sharedInstance = PostController()
    ///SOT
    var posts = [Post]()
    
    //MARK: - CRUD Functions
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment, PostError>) -> Void) {
        let newComment = Comment(text: text, post: post)
        post.comments.append(newComment)
    }
    
    func createPostWith (photo: UIImage, caption: String, completion: @escaping (Result<Post?, PostError>) -> Void) {
        let newPost = Post(photo: photo, caption: caption)
        posts.append(newPost)
    }
}//End of class
