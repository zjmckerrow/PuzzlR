//
//  Post.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 6/22/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

struct Post {
    
    var createdBy: User
    var timeAgo: String?
    var caption: String?
    var image: UIImage?
    var numberOfGoing: Int?
    var numberOfMaybe: Int?
    var numberOfComments: Int?
    var numberOfShares: Int?
    
    static func fetchPosts() -> [Post] {
        
        var posts = [Post]()
        
        let
        
    }
}
