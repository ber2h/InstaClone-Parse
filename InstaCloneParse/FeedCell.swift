//
//  FeedCell.swift
//  InstaCloneParse
//
//  Created by Bertuğ Horoz on 19.11.2022.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {

    @IBOutlet weak var postUUIDLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postUUIDLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeClicked(_ sender: Any) {
        
        let likeObject = PFObject(className: "Likes")
        likeObject["from"] = PFUser.current()!.username!
        likeObject["to"] = postUUIDLabel.text
        
        likeObject.saveInBackground { succes, error in
            if error != nil {
                self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                print("saved")
            }
        }
        
    }
    
    @IBAction func commentClicked(_ sender: Any) {
        
        let commentObject = PFObject(className: "Comments")
        commentObject["from"] = PFUser.current()!.username!
        commentObject["to"] = postUUIDLabel.text
        
        commentObject.saveInBackground { succes, error in
            if error != nil {
                self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                print("saved")
            }
        }
        
    }
    
    
    func MakeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput , preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
    
}
