//
//  ViewController.swift
//  TestLayoutBeta1
//
//  Created by Hieu Vo on 12/17/15.
//  Copyright © 2015 Hieu Vo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

 
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
  
    var fontStyle = FontStyle()
    let newTextFields = textFields()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set 2 textFields
        setTextAttributes(topTextField,text: "TOP")
        setTextAttributes(bottomTextField,text: "BOTTOM")
               // Do any additional setup after loading the view, typically from a nib.
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
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //Pick image from Camera
    @IBAction func pickImageFromCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // func for imagePickerCotroller delegate , set Image view after pick
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //func for cancel to pick photo
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)        
        
    }
    
    func keyboardWillShow(notification: NSNotification){
        if bottomTextField.editing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if (view.frame.origin.y != 0) {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
}

