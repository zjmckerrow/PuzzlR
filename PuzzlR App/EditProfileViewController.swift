//
//  EditProfileViewController.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 8/11/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Kingfisher

class EditProfileViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var backgroundPictureImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var changeBioTextView: UITextView!
    @IBOutlet weak var changeDisplayNameTextField: UITextField!
    var db: Firestore!
    var imagePicker = UIImagePickerController()
    var imagePicked = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        
        
        let profileImageURL = currentUser?.photoURL
        profilePictureImageView.kf.setImage(with: profileImageURL)
        
        displayNameLabel.text = currentUser?.displayName
        
        readDatabase()
        
    }
    
    func readDatabase() {
        
        let docRef = db.collection("users").document("\(String(describing: Auth.auth().currentUser?.uid))")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let docData = document.data()
                let bio = docData!["bio"] as? String
                self.bioLabel.text = bio
                let backgroundPictureURL = docData!["backgroundPictureURL"] as? URL
                self.backgroundPictureImageView.kf.setImage(with: backgroundPictureURL)
                
            }
            else {
                
                print("Document does not exist")
                
            }
            
        }
        
    }
    
    @IBAction func changeBackgroundPictureButtonPushed(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            
            imagePicked = sender.tag
            present(imagePicker, animated: true)
            
        }
        
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var pickedImage : UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            pickedImage = editedImage
            
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            pickedImage = image
            
        }
        else {
            
            //Error message
            
        }
        
        if let selectedImage = pickedImage {
            
            if imagePicked == 1 {
                
                backgroundPictureImageView.image = selectedImage
                
            }
            else if imagePicked == 2 {
                    
                profilePictureImageView.image = selectedImage
                
            }
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func changeProfilePictureButtonTapped(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            
            imagePicked = sender.tag
            present(imagePicker, animated: true)
            
        }
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let newDisplayName = changeDisplayNameTextField.text, !newDisplayName.isEmpty {
            

            
        }
        
    }
    
}
