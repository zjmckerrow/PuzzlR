//
//  AddInfoSIgnUpViewController.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 7/7/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddInfoSIgnUpViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var displayImage: UIImageView!
    var db : Firestore!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
    }
    
    @IBAction func addProfilePictureButtonTapped(_ sender: Any) {

        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = true
        self.present(image, animated : true) {
            
            // After it is complete
            
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
            
            displayImage.image = selectedImage
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            if displayName.text != nil {
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName.text
                changeRequest.commitChanges { (error) in
                    
                }
                
            }
            if displayImage.image != nil {
                
                let userID = user.uid
                let storage = Storage.storage()
                let storageRef = storage.reference().child("images/\(userID)/profilePicture/profileImage.png")
                if let uploadData = displayImage.image!.pngData() {
                
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        
                        if error != nil {
                            
                            print(error!)
                            return
                            
                        }
                        
                        storageRef.downloadURL(completion: { (url, error) in
                            
                            guard let downloadURl = url else {
                                return
                            }
                            
                            let changeRequest = user.createProfileChangeRequest()
                            changeRequest.photoURL = downloadURl
                            changeRequest.commitChanges { (error) in
                                
                            }
                            
                        })
                        
                    })
                    
                }
                
            }
            self.performSegue(withIdentifier: "infoToBio", sender: self)
                
        }
    
    }
    
}
