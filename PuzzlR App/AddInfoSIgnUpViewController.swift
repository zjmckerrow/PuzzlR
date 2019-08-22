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
import Kingfisher

class AddInfoSIgnUpViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
                changeRequest.commitChanges(completion: { (error) in
                    
                    return
                    
                })
                
            }
            
            if displayImage.image != nil {
                
                let userID = user.uid
                guard let image = displayImage.image, let data = image.pngData() else {
                    
                    let alertController = UIAlertController(title: "Error", message: "Something went wrong...", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                    
                }
                
                let imageName = UUID().uuidString
                let imageRef = Storage.storage().reference().child("images/\(userID)/profileImage/\(imageName)")
                imageRef.putData(data, metadata: nil) { (metadata, err) in
                    if let err = err {
                        
                        let alertController = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                        
                    }
                    
                    imageRef.downloadURL(completion: { (url, error) in
                        if let error = error {
                            
                            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                            return
                            
                        }
                        
                        guard let url = url else {
                            
                            let alertController = UIAlertController(title: "Error", message: "Something went wrong...", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                            return
                            
                        }
                        
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.photoURL = url
                        changeRequest.commitChanges(completion: { (error) in
                            
                            return
                            
                        })
                        
                    })
                    
                }
                
            }
 
            self.performSegue(withIdentifier: "infoToBio", sender: self)
                
        }
 
    }
    
}
