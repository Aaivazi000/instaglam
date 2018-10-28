//
//  CaptureViewController.swift
//  Instaglam
//
//  Created by Andriana Aivazians on 10/22/18.
//  Copyright © 2018 Andriana Aivazians. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Declarations and UI Outlets
    @IBOutlet weak var postImageView: UIImageView!
    var selectedforpostUIImage: UIImage?
    @IBOutlet weak var captionTextField: UITextField!
    var alertController = UIAlertController()
    
    
    //Resize Photo Function
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        resizeImageView.image = image
        
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    
    //Action when postImageView is tapped
    @IBAction func onimageTap(_ sender: Any) {
        selectPhoto()
    }
    
    //Select Photo function
    func selectPhoto() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
        
        //Un comment below if doing demontration not on Simulator.
        /*if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
         */
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        // Set image in the UI Image view in CaptureViewController
        postImageView.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    //Function when user clicks Submit Button
    @IBAction func onSubmitTap(_ sender: Any) {
        
        //Take image in UI Image View and set to var
        selectedforpostUIImage = postImageView.image
        
        //Create a post
        var caption = captionTextField.text
        if caption == "Add Caption Here" {
            caption = "No Caption"
        }
        Post.postUserImage(image: selectedforpostUIImage, withCaption: caption) { (success: Bool, error: Error?) -> Void in
            
            if let error = error {
                if self.postImageView.image == #imageLiteral(resourceName: "image_placeholder") {
                    self.alertController = UIAlertController(title: "Error", message: "\(String(describing: error.localizedDescription))", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel) {(action) in
                        //doing nothing will dismiss view
                    }
                    self.alertController.addAction(cancelAction)
                    DispatchQueue.global().async(execute: {
                        DispatchQueue.main.sync{
                            self.present(self.alertController, animated: true, completion: nil)
                        }
                    })
                }
            }
            else {
                self.alertController = UIAlertController(title: "Success", message: "You have shared a new post!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    //do nothing to dismiss
                }
                self.alertController.addAction(cancelAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(self.alertController, animated: true, completion: nil)
                        
                    }
                })
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
