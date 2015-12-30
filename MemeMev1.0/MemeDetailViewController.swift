//
//  MemeDetailViewController.swift
//  MemeMev1.0
//
//  Created by Hieu Vo on 12/29/15.
//  Copyright © 2015 Hieu Vo. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
    var indexMeme = 0
    let appVar = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var memeImage: UIImageView!
    override func viewDidAppear(animated: Bool){
        let meme = appVar.memes[indexMeme]
        memeImage.image = meme.MemedImage
        self.tabBarController?.tabBar.hidden = true
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: Selector("editMeme:"))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    func editMeme(sender : UIBarButtonItem){
        let MemeEditorVC = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(MemeEditorVC, animated: true, completion: nil)
    }
}
