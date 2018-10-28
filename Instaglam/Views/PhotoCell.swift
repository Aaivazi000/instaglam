//
//  PhotoCell.swift
//  Instaglam
//
//  Created by Andriana Aivazians on 10/27/18.
//  Copyright © 2018 Andriana Aivazians. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoCell: UITableViewCell {
    
    //UI Outlets and Variable Declarations
    @IBOutlet weak var photoPFImageView: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var uploadhoursLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var instagramPost: PFObject! {
        didSet {
            
            //Set text to UI Labels
            usernameLabel.text = (instagramPost["author"] as! PFUser).username
            if let timepassed = (instagramPost.createdAt) {
                let timeHours = Int(round(Double((timepassed.timeIntervalSinceNow * -1) / 3600)))
                print(timepassed.timeIntervalSinceNow)
                print(timeHours)
                if timeHours == 0 {
                    let timeMinutes = Int(round(Double((timepassed.timeIntervalSinceNow * -1) / 60)))
                    if timeMinutes == 1 {
                        uploadhoursLabel.text = String("Uploaded \(timeMinutes) min ago")
                    }
                    else {
                    uploadhoursLabel.text = String("Uploaded \(timeMinutes) mins ago")
                    }
                }
                else if timeHours == 1 {
                    uploadhoursLabel.text = String("Uploaded \(timeHours) hour ago")
                }
                else {
                    uploadhoursLabel.text = String("Uploaded \(timeHours) hours ago")
                }
            }
            captionLabel.text = instagramPost["caption"] as? String
            
            self.photoPFImageView.file = instagramPost["media"] as? PFFile
            self.photoPFImageView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
