//
//  ViewController.swift
//  MovieApp
//
//  Created by Chandan Singh on 04/03/19.
//  Copyright © 2019 Mindtree. All rights reserved.
//

import UIKit

class MAMovieListViewController: UIViewController {

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }
    
    //MARK: UI
    private func setupUI() -> Void {
        self.title = kHomeScreenTitle
    }
}

