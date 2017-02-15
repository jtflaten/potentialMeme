//
//  SentMemesTableViewController.swift
//  PotentialMeme
//
//  Created by Jake Flaten on 2/1/17.
//  Copyright © 2017 Break List. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [NewMeme]!
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        self.tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableViewCell", for: indexPath) as! SentMemeTableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.tableImageView?.image = meme.finishedImage
        cell.tableLabel?.text = meme.topText
        
        return cell
    }
        
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "ViewMemeViewController") as! ViewMemeViewController
    memeDetailController.meme = self.memes[(indexPath as NSIndexPath).row]
    self.navigationController!.pushViewController(memeDetailController, animated: true)
    }
    
//    @IBAction func pushToEditor(_ sender: AnyObject){
//        let potentialMemeController = self.storyboard!.instantiateViewController(withIdentifier: "PotentialMemeViewController") as! PotentialMemeViewController
//        self.navigationController!.pushViewController(potentialMemeController, animated: true)
//        
//    }
}

