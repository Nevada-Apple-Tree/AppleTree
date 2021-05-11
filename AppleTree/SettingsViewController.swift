//
//  SettingsViewController.swift
//  AppleTree
//
//  Created by user188190 on 4/9/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontSizeNumber: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var treeIDLabel: UILabel!
    @IBOutlet weak var treeIdField: UITextField!
    @IBOutlet weak var addIdButton: UIButton!
    @IBOutlet weak var groupIdsList: UILabel!
    
    
    @IBOutlet weak var UsernameLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func fontSizeStepper(_ sender: UIStepper) {
        fontSizeNumber.text = Int(sender.value).description
        
        globalsettingsvalues.globalfontsize = Int(sender.value)
        fontSizeLabel.font = fontSizeLabel.font.withSize(CGFloat(globalsettingsvalues.globalfontsize))
        notificationLabel.font = fontSizeLabel.font.withSize(CGFloat(globalsettingsvalues.globalfontsize))
        locationLabel.font = fontSizeLabel.font.withSize(CGFloat(globalsettingsvalues.globalfontsize))
        treeIDLabel.font = fontSizeLabel.font.withSize(CGFloat(globalsettingsvalues.globalfontsize))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profileImage = PFUser.current()!["ProfilePic"] as? PFFileObject {
            let urlString = profileImage.url!
            let url = URL(string: urlString)!
        
            userImage.af.setImage(withURL: url)
        }
            stepper.value = 17
        if let groupids = PFUser.current()!["groupids"] as? [String] {
            groupIdsList.text = groupids.joined(separator: ", ")
        } else {
            groupIdsList.text = ""
        }
        
     
        self.UsernameLabel.text = PFUser.current()!.username
        
        
        
       
        stepper.value = 17
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
            
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            
        sceneDelegate.window?.rootViewController = loginViewController
    }
    
    
    @IBAction func changeUserImage(_ sender: Any) {
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
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        userImage.image = image
        
        let imageData = userImage.image! .pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        PFUser.current()!["ProfilePic"] = file
        PFUser.current()?.saveInBackground(block: { (success, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                print("success")
            }
        })
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addIdButton(_ sender: Any) {
        var groupids = PFUser.current()!["groupids"] as? [String] ?? []
        if let text = treeIdField.text {
            groupids.append(text)
            
        PFUser.current()!["groupids"] = groupids
        PFUser.current()?.saveInBackground(block: { (success, error) in
            if let error = error {
                print (error.localizedDescription)
            } else {
                if self.groupIdsList.text!.isEmpty {
                self.groupIdsList.text?.append(text)
                } else {
                self.groupIdsList.text?.append(", "+text)
                }
                self.treeIdField.resignFirstResponder()
                self.treeIdField.text = ""
                
            }
        })
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
