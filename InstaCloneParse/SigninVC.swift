//
//  ViewController.swift
//  InstaCloneParse
//
//  Created by Bertuğ Horoz on 19.11.2022.
//

import UIKit
import Parse

class SigninVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         let parseOBject = PFObject(className: "Fruits")
         parseOBject["name"] = "Banana"
         parseOBject["calories"] = 300
         parseOBject.saveInBackground { success, error in
         if error != nil {
         print(error?.localizedDescription ?? "Error")
         } else {
         print("Saved")
         }
         }
         
        
        let query = PFQuery(className: "Fruits")
        query.whereKey("name", equalTo: "Apple")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                print(objects)
            }
         }
         */
        
        
        
    }
    @IBAction func singupClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { succes, error in
                if error != nil {
                    self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            self.performSegue(withIdentifier: "toTabBar", sender: nil)
        }
    }
    
    
    
    
    
    @IBAction func signinClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: usernameText.text! , password: passwordText.text!) { user, error in
                if error != nil {
                    self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        } else {
            MakeAlert(titleInput: "Error", messageInput: "Username / Password ?")
        }
    }
    
    
    
    
    func MakeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput , preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

