//
//  Post.swift
//  PhotoSharingApp
//
//  Created by Fatih Özen on 28.01.2023.
//

import Foundation

class Post {
   private var mail : String
   private var commend : String
   private var imageUrl : String
    
    init(mail: String, commend: String, imageUrl: String) {
        self.mail = mail
        self.commend = commend
        self.imageUrl = imageUrl
    }
    
    func getMail()->String{
        return mail
    }
    func getCommend()->String{
        return commend
    }
    func getImageUrl()->String{
        return imageUrl
    }
}
