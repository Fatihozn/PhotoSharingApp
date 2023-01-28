//
//  UpLoadViewController.swift
//  PhotoSharingApp
//
//  Created by Fatih Özen on 26.01.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

class UpLoadViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var textName : UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabImage))
        
        imageView.addGestureRecognizer(gestureRecognizer)
       
    }
    @objc func tabImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }

    @IBAction func upload(_ sender: UIButton){
        
        let storage = Storage.storage()
        let storageRefrence = storage.reference()
        let mediaFolder = storageRefrence.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let imageRefrence = mediaFolder.child("\(uuid).jpg")
            
            imageRefrence.putData(data) { (storagemetadata, error) in
                if error != nil {
                    self.presentAlert(title: "ERROR!", message: error?.localizedDescription ?? "there is an error please try again")
                }else{
                    imageRefrence.downloadURL { (url,error) in
                        if error == nil{
                            let imageurl = url?.absoluteString
                            
                            if let imageurl = imageurl {
                                
                                let fireStoreDataBase = Firestore.firestore()
                                let fireStorePost = ["imageurl" : imageurl , "commend" : self.textName.text!, "mail" : Auth.auth().currentUser!.email! , "date" : FieldValue.serverTimestamp() ] as [String : Any]
                                
                                fireStoreDataBase.collection("posts").addDocument(data: fireStorePost) { error in
                                    if error != nil {
                                        self.presentAlert(title: "ERROR!", message: error?.localizedDescription ?? "there is an error please try again")
                                    }else{
                                        self.imageView.image = UIImage(named: "choose image")
                                        self.textName.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
    func presentAlert(title: String,message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okButton)
        self.present(alertController, animated: true)
        
    }
   

}
