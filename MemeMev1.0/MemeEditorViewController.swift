//
//  MemeEditorViewController.swift
//  MemeMeV1.0
//
//  Created by Hieu Vo on 12/17/15.
//  Copyright © 2015 Hieu Vo. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

 
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!  
    @IBOutlet weak var toolBar: UIToolbar!
    
    var fontStyle = FontStyle()
    let newTextFields = textFields()
    var appVar = UIApplication.sharedApplication().delegate as! AppDelegate
    var indexMeme : Int?
    var memeEdit: Meme?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set 2 textFields
        setTextAttributes(topTextField,text: "TOP")
        setTextAttributes(bottomTextField,text: "BOTTOM")
        
        //check Edit mode?
        if let index = indexMeme {
            setUpImageToEdit(index)
        }
    }

    //Set up for Edit Mode
    func setUpImageToEdit(index : Int){
        memeEdit = appVar.memes[index]
        imageView.image = memeEdit?.image
        topTextField.text = memeEdit?.topText
        bottomTextField.text = memeEdit?.bottomText
    }
    func setTextAttributes(textField : UITextField, text : String) {
        let TextAttributes = [
            NSStrokeColorAttributeName : fontStyle.strokeColor,
            NSForegroundColorAttributeName : fontStyle.foregroundColor,
            NSFontAttributeName : fontStyle.font,
            NSStrokeWidthAttributeName : fontStyle.strokeWidth
        ]
        textField.delegate = newTextFields
        textField.defaultTextAttributes = TextAttributes
        textField.textAlignment = .Center
        textField.text = text        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // Pick Image from Photo Library source
    @IBAction func pickImageFromAlbum(){
    let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //Pick image from Camera
    @IBAction func pickImageFromCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Function for share Button
    @IBAction func shareActivity(sender: UIBarButtonItem) {
        if (imageView.image != nil){
            let memedImage = generateMemedImage()
            let activityVC = UIActivityViewController(activityItems : [memedImage], applicationActivities : nil)
            let excludeActivities = [UIActivityTypeMessage,UIActivityTypePostToFacebook,UIActivityTypeMail,UIActivityTypeAirDrop,UIActivityTypeAssignToContact]
            activityVC.excludedActivityTypes = excludeActivities
            activityVC.completionWithItemsHandler = { activity, completed, items, error in
                if completed {
                    //if edit Mode to edit Meme, else to create new
                    if let index = self.indexMeme {
                        self.appVar.memes[index] = self.saveMeme()
                    }else{
                        self.appVar.memes.append(self.saveMeme())
                    }
                        self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func Cancel() {
       dismissViewControllerAnimated(true, completion: nil)
    }

    // func for imagePickerCotroller delegate , set Image view after pick
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //func for cancel to pick photo
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(false, completion: nil)
       
    }
    
    // call KeyBoard when editing text
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:" , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    // close keyboard when text edited
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
        
    }
    
    // move view up when keyboard show
    func keyboardWillShow(notification: NSNotification){
        if bottomTextField.editing {
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    //Move view down when keyboad hide
    func keyboardWillHide(notification: NSNotification){
        if (bottomTextField.resignFirstResponder()) {
            view.frame.origin.y = 0
        }
    }
    
    //get height of keyboard
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().size.height
    }
    
    // function to make Meme Image
    func generateMemedImage() -> UIImage {
        navigationBar.hidden = true
        toolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        navigationBar.hidden = false
        toolBar.hidden = false
        return memedImage
    }
    
    // save all to meme object
    func saveMeme() -> Meme{
        let topText = topTextField.text
        let bottomText = bottomTextField.text
        let image = imageView.image
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topText!, bottomText: bottomText!, image: image!, MemedImage: memedImage)
        return meme
        
    }
}

