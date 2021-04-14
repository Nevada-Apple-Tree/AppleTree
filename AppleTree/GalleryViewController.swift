//
//  GalleryViewController.swift
//  AppleTree
//
//  Created by user188190 on 4/9/21.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    

}
  
extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        <#code#>
    }
}

