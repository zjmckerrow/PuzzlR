//
//  SignUpViewController.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 6/21/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
    
        if password.text != passwordConfirm.text {
           
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        
        }
        
        else {
            
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) {
                (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signUpToInfo", sender: self)
                    
                }
                else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                
                }
                
            }
        
        }
        
    }
    
}
