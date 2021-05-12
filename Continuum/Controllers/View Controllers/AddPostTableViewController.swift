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
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var addCaptionTextField: UITextField!
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectImageButton.setTitle("Select Image", for: .normal)
        selectedImageView.image = nil
        addCaptionTextField.text = ""
    }
    
    //MARK: - Actions
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        selectImageButton.setTitle("", for: .normal)
        selectedImageView.image = UIImage(named: "spaceEmptyState")
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let photo = selectedImageView.image, 
        let caption = addCaptionTextField.text, !caption.isEmpty else { return self.presentErrorAlert(title: "Error!", message: "Must insert a caption and a photo.") }
        
        PostController.sharedInstance.createPostWith(photo: photo, caption: caption) { (result) in }

        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
    }
    
}//End of class
