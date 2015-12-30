//
//  MemeTableViewController.swift
//  MemeMev1.0
//
//  Created by Hieu Vo on 12/29/15.
//  Copyright © 2015 Hieu Vo. All rights reserved.
//

import UIKit

class MemeTableViewController : UITableViewController{
    
    var appVar = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appVar.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell") as! MemeTableViewCell
        let meme = appVar.memes[indexPath.row]
        cell.memeImage.image = meme.MemedImage
        cell.memeTopLable.text = meme.topText
        cell.memeBottomLable.text = meme.bottomText
        return cell
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            appVar.memes.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailVC.indexMeme = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
