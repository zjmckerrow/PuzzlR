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
import FirebaseAuth

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
        image.allowsEditing = false
        self.present(image, animated : true) {
            
            // After it is complete
            
        }
        
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            displayImage.image = image
            
        }
        else {
            
            //Error message
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            let changeRequest = user.createProfileChangeRequest()
            if displayName.text != nil {
                
                changeRequest.displayName = displayName.text
                changeRequest.commitChanges { (error) in
                    
                }
                
            }
            if displayImage.image != nil {
                
                let userID = user.uid
                db.collection("users").document(userID).setData([
                
                    "profile picture" : displayImage.image!
                
                ])
            
            }
            self.performSegue(withIdentifier: "infoToBio", sender: self)
                
        }
    
    }
    
}
