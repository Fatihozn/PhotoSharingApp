//
//  FeedViewController.swift
//  PhotoSharingApp
//
//  Created by Fatih Özen on 26.01.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchDatas()
        
    }
    func fetchDatas(){
        let fireStoreDataBase = Firestore.firestore()
        
        fireStoreDataBase.collection("posts").order(by: "date", descending: true)
            .addSnapshotListener { (snapShot,error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapShot?.isEmpty != true && snapShot != nil {
                    
                    self.posts.removeAll()
                    
                    for document in snapShot!.documents {

                        if let imageurl = document.get("imageurl") as? String{
                            if let mail = document.get("mail") as? String{
                                if let commend = document.get("commend") as? String{
                                    let post = Post(mail: mail, commend: commend, imageUrl: imageurl)
                                    self.posts.append(post)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCells
        
        cell.mailLabel.text = posts[indexPath.row].getMail()
        cell.commendLabel.text = posts[indexPath.row].getCommend()
        cell.postImageView.sd_setImage(with: URL(string : self.posts[indexPath.row].getImageUrl()))
        
        return cell
    }
    


}
