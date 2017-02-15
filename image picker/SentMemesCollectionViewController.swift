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
        layoutCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        self.collectionView?.reloadData()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
    }
    
    struct Constants {
        static let cellVerticalSpaicng: CGFloat = 2
    }
    
    func layoutCells() {
        var cellWidth: CGFloat
        var cellsInRow: CGFloat
        flowLayout.invalidateLayout()
        
        switch UIDevice.current.orientation {
        case .portrait:
            cellsInRow = 3
        case .portraitUpsideDown:
            cellsInRow = 3
        case .landscapeLeft:
            cellsInRow = 5
        case.landscapeRight:
            cellsInRow = 5
        default:
            cellsInRow = 5
        }
        cellWidth = collectionView!.frame.width / cellsInRow
        cellWidth -= Constants.cellVerticalSpaicng
        flowLayout.itemSize.width = cellWidth
        flowLayout.itemSize.height = cellWidth
        flowLayout.minimumInteritemSpacing = Constants.cellVerticalSpaicng
        let actualVerticalSpacing: CGFloat = (collectionView!.frame.width - (cellsInRow * cellWidth))/(cellsInRow - 1)
        flowLayout.minimumLineSpacing = actualVerticalSpacing
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "ViewMemeViewController") as! ViewMemeViewController
        memeDetailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(memeDetailController, animated: true) //present(memeDetailController, animated: true, completion: nil)
    }
    
    @IBAction func pushToEditor(_ sender: AnyObject){
        let potentialMemeController = self.storyboard!.instantiateViewController(withIdentifier: "PotentialMemeViewController") as! PotentialMemeViewController
        self.navigationController!.pushViewController(potentialMemeController, animated: true)
        
    }
}
