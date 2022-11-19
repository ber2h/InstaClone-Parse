//
//  FirstViewController.swift
//  InstaCloneParse
//
//  Created by Bertuğ Horoz on 19.11.2022.
//

import UIKit
import Parse

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //tableview e sıralamak için liste halinde tanımlamalar yaptık.
    var postOwnerArray = [String]()
    var postCommentArray = [String]()
    var postUUIDArray = [String]()
    var postImageArray = [PFFileObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPost"), object: nil) //upload sonrası newpostu çekip koyma
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        PFUser.logOutInBackground { error in
            if error != nil{
                self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                self.performSegue(withIdentifier: "toSigninVC", sender: nil)
            }
        }
    }
    
    func MakeAlert(titleInput : String , messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput , preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postOwnerArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for : indexPath) as! FeedCell
        cell.usernameLabel.text = postOwnerArray[indexPath.row]
        cell.commentLabel.text = postCommentArray[indexPath.row]
        cell.postUUIDLabel.text = postUUIDArray[indexPath.row]
        
        postImageArray[indexPath.row].getDataInBackground { data, error in
            if error != nil {
                self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                cell.postImage.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    
    @objc func getData () {
        
        let query = PFQuery(className: "Posts")
        
        query.addDescendingOrder("createdAt") //sıralaması için 
        
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.MakeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                
                self.postImageArray.removeAll()
                self.postUUIDArray.removeAll()
                self.postOwnerArray.removeAll()
                self.postCommentArray.removeAll()
                
                if objects!.count > 0 {
                    for object in objects! {
                        self.postOwnerArray.append(object.object(forKey: "postowner") as! String)
                        self.postCommentArray.append(object.object(forKey: "postcomment") as! String)
                        self.postUUIDArray.append(object.object(forKey: "postid") as! String)
                        self.postImageArray.append(object.object(forKey: "postimage") as! PFFileObject)
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
}


