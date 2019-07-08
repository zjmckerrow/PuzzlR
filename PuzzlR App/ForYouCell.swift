//
//  ForYouCell.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 7/7/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit

class ForYouCell: UICollectionViewCell {
    
    @IBOutlet weak var companyImage: UIImageView!
    
    func displayContent(image: UIImage) {
        
        companyImage.image = image
    
    }
    
}
