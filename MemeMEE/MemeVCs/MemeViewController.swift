//
//  MemeViewController.swift
//  MemeMEE
//
//  Created by khalid alhazmi on 17/03/2019.
//  Copyright © 2019 khalid alhazmi. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController      //UITextFieldDelegate
{
    
    
    //MARK: outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    //varable
    var topfisrtinput = true
    var bottomfisrtinput = true
    let imagePicker = UIImagePickerController()
    let textField = UITextField()
    //defalt font and  color
    var color = UIColor.white
    var font  = "HelveticaNeue-CondensedBlack"
    
    //defaltTextAttributes
    var memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor:UIColor.black ,
        .foregroundColor:UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -3
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //chick avalablity of camera and photolibrary 
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        albumButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        cancelButton.isEnabled = false
        shareButton.isEnabled = false
        
        //defalt color and font
        memeTextAttributes[.foregroundColor] = UIColor.white
        memeTextAttributes[.font] = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)
        
        setupTextField(topTextField,text: "TOP")
        setupTextField(bottomTextField,text: "BOTTOM")
        
        topfisrtinput = true
        bottomfisrtinput = true
        
        //image
        imageView.image = nil
    }
    
    
    //MARK: functions
    
    //call UIimagepicker
    func presentPickerViewController(source: UIImagePickerController.SourceType) {
        imagePicker.delegate=self
        present(imagePicker, animated: true, completion: nil)
    }
    //create meme image
    func generateMemedImage() -> UIImage {
        toolBar.isHidden = true
        navigationBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        toolBar.isHidden = false
        navigationBar.isHidden = false
        return memedImage
    }
    //save image
    func save() {
        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, image: imageView.image, memeImage: generateMemedImage())
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
        print("ss ", appDelegate.memes.count)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
  
    //Action of buttons
    @IBAction func pickFromCamera(_ sender: Any) {
        presentPickerViewController(source: .camera)
    }
    @IBAction func pickFromAlbum(_ sender: Any) {
        presentPickerViewController(source: .photoLibrary)
    }
    
    @IBAction func cancel(_ sender: Any) {
        viewDidLoad()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil )
        present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = { _, success, _, _ in
            if success {
                self.save()
            }
        }
    }
    
    
//seque to StyleController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sequeStyleController" {
            let controller : StyleViewController = segue.destination as! StyleViewController
            controller.color = self.color
            controller.font = self.font
            controller.styleTextAttributes = memeTextAttributes
            controller.delegate = self
        }
        cancelButton.isEnabled = true
        
    }
    
}
// call the protocol to return the data and change the style
extension MemeViewController : StyleViewDelegate {
    func moveData(color: UIColor, font: String) {
            // to keep the word when we change the style
            let topText : String = topTextField.text!
            let  bottomText : String = bottomTextField.text!
        
            self.color = color
            self.font  = font
            self.memeTextAttributes[.foregroundColor] = color
            self.memeTextAttributes[.font] = UIFont(name: font, size: CGFloat(40))
            self.setupTextField(self.topTextField,text: topText)
            self.setupTextField(self.bottomTextField, text: bottomText)
        
    }
}
