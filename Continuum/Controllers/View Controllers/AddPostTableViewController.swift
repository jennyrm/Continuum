//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var addCaptionTextField: UITextField!
    
    //MARK: - Properties
    var selectedImage: UIImage?
    
    //MARK: - Lifecycle
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addCaptionTextField.text = ""
    }
    
    //MARK: - Actions
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let photo = selectedImage,
              let caption = addCaptionTextField.text, !caption.isEmpty else { return self.presentErrorAlert(title: "Error!", message: "Must insert a caption and a photo.") }
        
        PostController.sharedInstance.createPostWith(photo: photo, caption: caption) { (result) in }
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectorVC" {
            guard let destinationVC = segue.destination as? PhotoSelectorViewController else { return }
            destinationVC.delegate = self
        }
    }
    
}//End of class

//MARK: - Extensions
extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    
    func photoSelectorViewControllerSelected(image: UIImage) {
        selectedImage = image
    }
    
}//End of extension
