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
        self.tabBarController?.tabBar.hidden = true
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: Selector("editMeme:"))
        self.navigationItem.rightBarButtonItem = editButton
        swipeFunction()
        getMeme(indexMeme)
    }
    //Add swipe function
    func swipeFunction(){
        let swipeLeftChange = UISwipeGestureRecognizer(target: self, action: Selector("changeMeme:"))
        let swipeRightChange = UISwipeGestureRecognizer(target: self, action: Selector("changeMeme:"))
        swipeLeftChange.direction = .Left
        swipeRightChange.direction = .Right
        view.addGestureRecognizer(swipeLeftChange)
        view.addGestureRecognizer(swipeRightChange)
    }
    
    //Action when user swipe on screen
    func changeMeme(sender : UISwipeGestureRecognizer){
        if sender.direction == UISwipeGestureRecognizerDirection.Left{
            if (indexMeme - 1 >= 0){
            indexMeme = ((indexMeme - 1) < 0) ? 0 : (indexMeme - 1)
            getMeme(indexMeme)
            }else{
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        if sender.direction == .Right{
            indexMeme = ((indexMeme + 1) >= appVar.memes.count) ? (appVar.memes.count - 1) : (indexMeme + 1)
            getMeme(indexMeme)
        }

    }

    //function for edit button
    func editMeme(sender : UIBarButtonItem){
        let MemeEditorVC = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        MemeEditorVC.indexMeme = indexMeme
        self.presentViewController(MemeEditorVC, animated: true, completion: nil)
    }
    
    //get Meme from array
    func getMeme(indexMeme : Int){
        let meme = appVar.memes[indexMeme]
        memeImage.image = meme.MemedImage    }
}
