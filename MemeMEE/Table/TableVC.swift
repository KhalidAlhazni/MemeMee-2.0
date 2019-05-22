//
//  TableVC.swift
//  MemeMEE
//
//  Created by khalid alhazmi on 21/05/2019.
//  Copyright © 2019 khalid alhazmi. All rights reserved.
//

import Foundation
import UIKit
class TableVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    //MARK: vars
    var memes: [Meme]!
    
    //MARK: outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delagate tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        //the + button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addNewMeme))
        self.navigationItem.title = "Meme Me"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //the + button
    @objc func addNewMeme() {
        var controller: MemeViewController
        controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.memes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"TableCell")!
        
        cell.imageView?.image = appDelegate.memes[indexPath.row].memeImage
        cell.textLabel?.text = appDelegate.memes[indexPath.row].topText! + "...." + appDelegate.memes[indexPath.row].bottomText!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        detailController.meme = appDelegate.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
}
