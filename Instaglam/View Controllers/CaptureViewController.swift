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
        
        //Check if photo size is under 10MB and reduce if necessary
        
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
