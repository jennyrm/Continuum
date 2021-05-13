//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Jenny Morales on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

class PhotoSelectorViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    //MARK: - Properties
    weak var delegate: PhotoSelectorViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectImageButton.setTitle("Select Image", for: .normal)
        selectedImageView.image = nil
    }
    
    //MARK: - Actions
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Photos", message: "Choose image from your camera or photo library", preferredStyle: .actionSheet)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated: true)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            self.dismiss(animated: true)
        }))
        
        present(alertController, animated: true)
        
    }
    
}//End of class

//MARK: - Extensions
extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImageButton.setTitle("", for: .normal)
            selectedImageView.image = photo
            delegate?.photoSelectorViewControllerSelected(image: photo)
        } else {
            selectedImageView.image = UIImage(named: "noImageAvailable")
        }
    }
    
}//End of extension
