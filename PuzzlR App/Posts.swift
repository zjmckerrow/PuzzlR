//
//  Posts.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 6/30/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

struct Posts {
    
    var createdBy : User
    var timeAgo : String?
    var caption : String?
    var postImage : UIImage?
    var numberOfGoing : Int?
    var numberOfComments : Int?
    var numberOfShares : Int?
    
}

struct User {
    
    var username : String?
    var profileImage : UIImage?
    
}
