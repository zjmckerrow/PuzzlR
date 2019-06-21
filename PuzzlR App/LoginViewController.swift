//
//  LoginViewController.swift
//  PuzzlR App
//
//  Created by Zach McKerrow on 6/8/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        ToMainInterface()
        
    }
    
    private func ToMainInterface() {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let mainNavigationViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController else {
            return
        }
        
        print(mainNavigationViewController.topViewController)
        print(mainNavigationViewController.viewControllers)
        
        if let mainVC = mainNavigationViewController.topViewController as? ViewController {
            mainVC.username = usernameTextField.text
            mainVC.password = passwordTextField.text
        }
        
        present(mainNavigationViewController, animated: true, completion: nil)
        
    }
    
}
