//
//  SentMemesCollectionViewController.swift
//  PotentialMeme
//
//  Created by Jake Flaten on 2/2/17.
//  Copyright © 2017 Break List. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [NewMeme]!
    
    @ IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let space: CGFloat = 3
        let heightDimension = (self.view.frame.size.height - (2 * space)) / 3.0
        let widthDimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
       
        cell.memeImageView?.image = meme.finishedImage
        
        return cell
    }
    
    @IBAction func pushToEditor(_ sender: AnyObject){
        let potentialMemeController = self.storyboard!.instantiateViewController(withIdentifier: "PotentialMemeViewController") as! PotentialMemeViewController
        self.navigationController!.pushViewController(potentialMemeController, animated: true)
        
    }
}
