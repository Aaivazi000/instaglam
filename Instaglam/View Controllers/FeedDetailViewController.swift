//
//  FeedDetailViewController.swift
//  Instaglam
//
//  Created by Andriana Aivazians on 10/27/18.
//  Copyright © 2018 Andriana Aivazians. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedDetailViewController: UIViewController {

   // UI Outlets & Varible Declarations
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailcaptionLabel: UILabel!
    @IBOutlet weak var detailusernameLabel: UILabel!
    @IBOutlet weak var detailuploadtimeLabel: UILabel!
    @IBOutlet weak var detailPFImageView: PFImageView!
    var detailpost: PFObject?
    
    @IBAction func onDoneTap(_ sender: Any) {
        self.performSegue(withIdentifier: "backtofeedSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let detailpost = detailpost {
            
        //Set values from detailpost into UI Elemtents
        detailusernameLabel.text = (detailpost["author"] as! PFUser).username
            
        if let timepassed = (detailpost.createdAt) {
            let timeHours = Int(round(Double((timepassed.timeIntervalSinceNow * -1) / 3600)))
            print(timepassed.timeIntervalSinceNow)
            print(timeHours)
            if timeHours == 0 {
                let timeMinutes = Int(round(Double((timepassed.timeIntervalSinceNow * -1) / 60)))
                if timeMinutes == 1 {
                    detailuploadtimeLabel.text = String("Uploaded \(timeMinutes) min ago")
                }
                else {
                    detailuploadtimeLabel.text = String("Uploaded \(timeMinutes) mins ago")
                }
            }
            else if timeHours == 1 {
                detailuploadtimeLabel.text = String("Uploaded \(timeHours) hour ago")
            }
            else {
                detailuploadtimeLabel.text = String("Uploaded \(timeHours) hours ago")
            }
        }
        // Set caption Label
        detailcaptionLabel.text = detailpost["caption"] as? String
        
        // Set Photo Image
        self.detailPFImageView.file = detailpost["media"] as? PFFile
        self.detailPFImageView.loadInBackground()
    }
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
