//
//  SettingsViewController.swift
//  PhotoSharingApp
//
//  Created by Fatih Özen on 26.01.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: UIButton){
        
        do{
            try  Auth.auth().signOut()
            performSegue(withIdentifier: "toSigninVC", sender: nil)
        }catch{
           print("hata")
        }
       
       
    }


}
