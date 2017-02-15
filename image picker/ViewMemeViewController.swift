//
//  ViewMemeViewController.swift
//  PotentialMeme
//
//  Created by Jake Flaten on 2/3/17.
//  Copyright © 2017 Break List. All rights reserved.
//

import Foundation
import UIKit

class ViewMemeViewController:  UIViewController {
    
    var meme: NewMeme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.finishedImage
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector (editMeme))
    }
    
    
    
  func editMeme() {
        let editController = self.storyboard!.instantiateViewController(withIdentifier: "PotentialMemeViewController") as! PotentialMemeViewController
        editController.meme = self.meme
        self.navigationController!.pushViewController(editController, animated: true)         
    }
}
