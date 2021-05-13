//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var postSearchBar: UISearchBar!
    
    
    //MARK: - Properties
    var resultsArray = [SearchableRecord]()
    var isSearching = false
    
    var dataSource: [SearchableRecord] {
        return isSearching ? resultsArray : PostController.sharedInstance.posts
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultsArray = PostController.sharedInstance.posts
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = dataSource[indexPath.row]
        cell.post = post as? Post
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? PostDetailTableViewController else { return }
            let postToSend = PostController.sharedInstance.posts[indexPath.row]
            destinationVC.post = postToSend
        }
    }

}//End of class

//MARK: - Extensions
extension PostListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultsArray = PostController.sharedInstance.posts.filter { $0.matches(searchTerm: searchText) }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultsArray = PostController.sharedInstance.posts
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//          searchBar.text = ""
        isSearching = false
    }
}//End of extension
