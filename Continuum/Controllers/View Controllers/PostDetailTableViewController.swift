//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //MARK: - Actions
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        presentCommentAlertController()
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func followPostButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Functions
    func updateViews() {
        guard let post = post else { return }
        photoImageView.image = post.photo
        tableView.reloadData()
    }
    
    func presentCommentAlertController() {
        let alertController = UIAlertController(title: "Comment", message: "Write a comment", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter comment here..."
            textfield.autocorrectionType = .yes
            textfield.autocapitalizationType = .sentences
            //textfield.delegate = self
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else { return self.presentErrorAlert(title: "Error!", message: "Must add a comment.") }
            guard let post = self.post else { return }
            PostController.sharedInstance.addComment(text: text, post: post) { (_) in }
            self.tableView.reloadData()
        }))
        
        present(alertController, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postDetailCell", for: indexPath)
        let comment = post?.comments[indexPath.row].text
        cell.textLabel?.text = comment
        cell.detailTextLabel?.text = post?.timestamp.formatToString()
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}//End of class
