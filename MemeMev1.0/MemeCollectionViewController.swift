//
//  MemeCollectionViewController.swift
//  MemeMev1.0
//
//  Created by Hieu Vo on 12/30/15.
//  Copyright © 2015 Hieu Vo. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UICollectionViewController{
    
    let appVar = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidAppear(animated: Bool) {
        
        collectionView?.reloadData()
        let space: CGFloat = 3.0
        let sizeHeight = view.frame.size.height
        let sizeWidth = view.frame.size.width
        let dimensionWidth = ((sizeWidth < sizeHeight ? sizeWidth:sizeHeight) - (2 * space)) / 3.0
        let dimensionheight = (sizeWidth > sizeHeight ? sizeWidth:sizeHeight - (2 * space)) / 5.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimensionWidth, dimensionheight)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appVar.memes.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as? MemeCollectionViewCell
        let memes = appVar.memes[indexPath.row]
        cell?.memeImage.image = memes.MemedImage
        return cell!
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailVC.indexMeme = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
