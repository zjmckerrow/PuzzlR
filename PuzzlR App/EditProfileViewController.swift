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

class EditProfileViewController : UIViewController {
    
    @IBOutlet weak var backgroundPictureImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var changeBioTextView: UITextView!
    var db: Firestore!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        
        let profileImageURL = currentUser?.photoURL
        profilePictureImageView.kf.setImage(with: profileImageURL)
        
        displayNameLabel.text = currentUser?.displayName
     
    }
    
    func readArray() {
        
        self.db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                
                print("Error getting documents: \(error)")
            
            }
            else {
                
                for document in snapshot!.documents {
                    
                    self.bioLabel.text = (document.get("bio") as! String)
                    let backgroundImageURL = document.get("backgroundImageURL") as! URL
                    self.backgroundPictureImageView.kf.setImage(with: backgroundImageURL)
                
                }
            
            }
        
        }
        
    }
    
    
    @IBAction func changeBackgroundPictureButtonPushed(_ sender: Any) {
        
        
        
    }
    
    @IBAction func changeProfilePictureButtonTapped(_ sender: Any) {
        
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
        
    }
    
    
    
}
