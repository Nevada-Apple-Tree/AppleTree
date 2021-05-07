//
//  TreeAnnotation.swift
//  AppleTree
//
//  Created on 5/6/21.
//

import Foundation
import Parse
import MapKit

class TreeAnnotation: MKPointAnnotation {
    var familyMember: PFUser
    var imageView: UIImageView
    
    init(user: PFUser) {
        familyMember = user;
        self.imageView = UIImageView()
        super.init()
        self.title = user.username
        
        if let userLocation = user["myLocation"] as? PFGeoPoint {
            self.coordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        
        if let profileImage = user["ProfilePic"] as? PFFileObject {
            let urlString = profileImage.url!
            let url = URL(string: urlString)!
            
            self.imageView.af.setImage(withURL: url)
        } else {
            self.imageView.image = UIImage(systemName: "person.circle.fill")
        }
    }
}
