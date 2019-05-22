//
//  DetailedVC.swift
//  MemeMEE
//
//  Created by khalid alhazmi on 22/05/2019.
//  Copyright © 2019 khalid alhazmi. All rights reserved.
//

import Foundation
import UIKit
class DetailedVC: UIViewController {
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = meme.memeImage
    }
}
