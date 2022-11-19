//
//  SecondViewController.swift
//  InstaCloneParse
//
//  Created by Bertuğ Horoz on 19.11.2022.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Image Choose User Enabled
        imageView.isUserInteractionEnabled = true
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        imageView.addGestureRecognizer(gestureRec)
        //Upload Button False
        uploadButton.isEnabled = false
        
    }
                                                 
                                                 
    
    @IBAction func uploadClicked(_ sender: Any) {
        
        uploadButton.isEnabled = false
        //Image Get
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        let pfImage = PFFileObject(name: "image", data: data!)
        //ID Get
        let uuid = UUID().uuidString
        let uuidPost = "\(uuid) \(PFUser.current()!.username!)" //For the detailed id
        //Parse Upload
        let object = PFObject(className: "Posts")
        object["postcomment"] = commentText.text
        object["postowner"] = PFUser.current()!.username!
        object["postimage"] = pfImage
        object["postid"] = uuidPost
        
        object.saveInBackground { succes, error in
            if error != nil {
                self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                self.commentText.text = ""
                self.imageView.image = UIImage(named: "select.png")
                self.tabBarController?.selectedIndex = 0 //to Feed Controller -> tab bar olduğu için bu komutla gidebildik
                NotificationCenter.default.post(name: NSNotification.Name("newPost"), object: nil) //upload ettikten sonra anasayfada gözükmesi için
            }
        }
        
    }
    

    @objc func choosePhoto(){
        //Photo choose
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
            
    }
        //How to save photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        uploadButton.isEnabled = true
    }
    
    
    
    func MakeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput , preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
                                         
