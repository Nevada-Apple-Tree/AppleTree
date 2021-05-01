//
//  FamilyFeedCell.swift
//  AppleTree
//
//  Created by user188190 on 4/15/21.
//

import UIKit
import Parse


class FamilyFeedCell: UITableViewCell,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Posed image, author, and comment
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    //User profile image
    @IBOutlet weak var mainUserProfile: UIImageView!
    
    //Checks if user has a prifile image
    override func layoutSubviews() {
        super.layoutSubviews()
        
            mainUserProfile.layer.cornerRadius = 25
            mainUserProfile.clipsToBounds = true
            
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
