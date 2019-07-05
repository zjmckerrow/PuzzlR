//
//  NewsFeedViewController.swift
//  PuzzlR_App
//
//  Created by Zach McKerrow on 6/30/19.
//  Copyright © 2019 PuzzlR. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedViewController: UITableViewController {
    
    var searchController : UISearchController!
    var posts: [Posts]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupSearchController()
        self.fetchPosts()
        
    }
    
    func setupSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.barStyle = .black
        
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
    }
    
    func fetchPosts() {
        
        
        
    }
    
    
}
