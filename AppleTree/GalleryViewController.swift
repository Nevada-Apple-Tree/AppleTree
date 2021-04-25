//
//  GalleryViewController.swift
//  AppleTree
//
//  Created by user188190 on 4/9/21.
//

import UIKit
import AlamofireImage
import Parse
import Photos

class GalleryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var galleryImage: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryImage.isUserInteractionEnabled = true
        galleryImage.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(imageTap)))
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func onSubmit(_ sender: Any) {
        let post = PFObject(className:  "Posts")
        
        post["caption"] = textField.text!
        post["author"] = PFUser.current()!
        
        let imageData = galleryImage.image! .pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("error!")
            }
        }
    }


    @objc func imageTap(_ sender: Any) {
    print("1")
        let picker = UIImagePickerController()
        let alert = UIAlertController(title: "Image from Camera or Gallery", message: "Please select either camera or gallery for images.", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (action) in
            print("Clicked camera")
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (action) in
            print("Clicked gallery")
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
            print("Cancel")
        }))
        self.present(alert, animated: true, completion: nil)
        
    
    
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.editedImage] as! UIImage
    
    let size = CGSize(width: 300, height: 300)
    let scaledImage = image.af_imageAspectScaled(toFit: size)
    
    galleryImage.image = scaledImage
    
    self.dismiss(animated: true, completion: nil)
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}



    
    
    
    

