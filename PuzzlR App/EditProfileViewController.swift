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
    var currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        let profileImageURL = currentUser?.photoURL
        profilePictureImageView.kf.setImage(with: profileImageURL)
        
        displayNameLabel.text = currentUser?.displayName
        
        readDatabase()
        
    }
    
    func readDatabase() {
        
        let docRef = db.collection("users").document("\(String(describing: currentUser?.uid))")
        
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
        
        changeDisplayName()
        changeProfilePicture()
        changeBackgroundPicture()
        
    }
    
    func changeDisplayName() {
        
        if let newDisplayName = changeDisplayNameTextField.text, !newDisplayName.isEmpty {
            
            let changeRequest = currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = newDisplayName
            changeRequest?.commitChanges(completion: { (error) in
                
                print("Error : \(String(describing: error))")
                
            })
            
        }
        
    }
    
    func changeProfilePicture() {
        
        guard let image = profilePictureImageView.image, let data = image.pngData() else {
            
            let alertController = UIAlertController(title: "Error", message: "Something went wrong updating your profile picture", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
            
        }
        
        let imageName = UUID().uuidString
        let imageRef = Storage.storage().reference().child("images/\(String(describing: currentUser?.uid))/profileImage/\(imageName)")
        imageRef.putData(data, metadata: nil) {
            (metadata, err) in
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
                    
                    let alertController =  UIAlertController(title: "Error", message: "Something went wrong...", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                    
                }
                
                let changeRequest = self.currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges(completion: { (error) in
                    
                    return
                    
                })
                
            })
            
        }
        
    }
    
    func changeBackgroundPicture() {
        
        guard let image = backgroundPictureImageView.image, let data = image.pngData() else {
            
            let alertController = UIAlertController(title: "Error", message: "Something went wrong updating your background picture", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
            
        }
        
        let imageName = UUID().uuidString
        let imageRef = Storage.storage().reference().child("images/\(String(describing: currentUser?.uid))/backgroundImage/\(imageName)")
        imageRef.putData(data, metadata: nil) {
            (metadata, err) in
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
                    
                    let alertController =  UIAlertController(title: "Error", message: "Something went wrong...", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                    
                }
                
                let urlString = url.absoluteString
                let docRef = self.db.collection("users").document("\(String(describing: self.currentUser?.uid))")
                
                docRef.setData(<#T##documentData: [String : Any]##[String : Any]#>, completion: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
                
                return
                    
                })
                
            })
            
        }
    
    }
    
}
