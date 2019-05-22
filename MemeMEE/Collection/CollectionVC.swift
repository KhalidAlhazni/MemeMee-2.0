
//  CollectionVC.swift
//  MemeMEE
//
//  Created by khalid alhazmi on 21/05/2019.
//  Copyright © 2019 khalid alhazmi. All rights reserved.
//

import Foundation
import UIKit

class CollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    //MARK: var
    var memes: [Meme]!
    //MARK: outlet
    @IBOutlet var colloction: UICollectionView!

   
        override func viewDidLoad() {
        super.viewDidLoad()
        
        colloction.delegate = self
        colloction.dataSource = self
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addNewMeme))
        self.navigationItem.title = "Meme Me"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        colloction.reloadData()
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //the + button
    @objc func addNewMeme() {
        var controller: MemeViewController
        controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        self.present(controller, animated: true, completion: nil)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CollectionCell", for: indexPath) as! CollectionCell
    
        cell.image.image = appDelegate.memes[indexPath.row].memeImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        detailController.meme = appDelegate.memes[indexPath.row]
        
        navigationController!.pushViewController(detailController, animated: true)
    }
    
   
    
    
    
    
    
}


