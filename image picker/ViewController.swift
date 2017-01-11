//
//  ViewController.swift
//  image picker
//
//  Created by Jake Flaten on 11/10/16.
//  Copyright © 2016 Break List. All rights reserved.
//

import UIKit

class PotentialMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var albumPick: UIBarButtonItem!
    @IBOutlet weak var cameraPic: UIBarButtonItem!
    

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureTextFields(textField: topText)
        configureTextFields(textField: bottomText)
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraPic.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = (imageView.image == nil) ? false : true
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func configureTextFields(textField: UITextField) {
        
        let memeTextAttributes: [String:Any] = [ NSStrokeColorAttributeName: UIColor.black, NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Impact", size: 40)!, NSStrokeWidthAttributeName: NSNumber(value: -3.0)]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
        textField.clearsOnBeginEditing = true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
        imageView.image = image
        dismiss(animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder{
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
            self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }
    
   

   
    
    func saveMeme(_ memeImage: UIImage) {
        let meme = NewMeme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imageView.image!, finishedImage: memeImage)
        
    }
    
    func generateFinishedImage() -> UIImage {
        
        toolBar.isHidden = true
        navBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        navBar.isHidden = false
        
        return memeImage
    }
    
    func pickImageFromSource(source: UIImagePickerControllerSourceType){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        pickerController.sourceType = source
        
    }
    
    @IBAction func pickImageFromAlbum(_ sender: AnyObject) {
    
        pickImageFromSource(source: .photoLibrary)

    }
    
    @IBAction func newImage(_ sender: AnyObject) {
       
        pickImageFromSource(source: .camera )
        
    }
    
    @IBAction func shareNewMeme(_ sender: AnyObject) {
        let newMeme = generateFinishedImage()
        let shareController = UIActivityViewController(activityItems: [newMeme], applicationActivities: nil)
        self.present(shareController, animated: true, completion: nil)
        shareController.completionWithItemsHandler = {
         (activity, completed, returned, error) in
            if (completed){
                self.saveMeme(newMeme)
                self.dismiss(animated: true, completion: nil)
                self.topText.text = "TOP"
                self.bottomText.text = "BOTTOM"
                self.imageView.image = nil
               
            }
        }
       
    }

    @IBAction func cancelProgress(_ sender: AnyObject) {
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        imageView.image = nil
    }
}

