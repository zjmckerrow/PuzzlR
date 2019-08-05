//
//  SettingsController.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 8/5/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SettingsController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            
            try firebaseAuth.signOut()
        
        }
        
        catch let signOutError as NSError {
            
            print("Error signing out: %@", signOutError)
            
        }
        performSegue(withIdentifier: "settingsToLogIn", sender: self)
        
    }
    
}
