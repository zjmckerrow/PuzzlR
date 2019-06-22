//
//  StartViewController.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 6/21/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class StartViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
        
    }
    
}
