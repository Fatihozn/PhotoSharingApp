//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Fatih Özen on 25.01.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func signUp(_ sender: UIButton){
        
        if(mailText.text != "" && passwordText.text != ""){
            Auth.auth().createUser(withEmail: mailText.text!, password: passwordText.text!) {
                (authdataresult, error) in
                if error != nil {
                    self.presentAlert(title: "ERROR!", message: error?.localizedDescription ?? "there is an error please try again")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            self.presentAlert(title: "ERROR!", message: "Please ! enter your e-mail and password ")
        }
    }
    @IBAction func signIn(_ sender: UIButton){
        
        if mailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: mailText.text!, password: passwordText.text!) { (authdataresult , error) in
                if error != nil {
                    self.presentAlert(title: "ERROR!", message: error?.localizedDescription ?? "there is an error please try again" )
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            self.presentAlert(title: "ERROR!", message: "Please ! enter your e-mail and password ")
        }
    }
    
   public func presentAlert(title: String , message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okButton)
        self.present(alertController, animated: true)
        
    }

}

