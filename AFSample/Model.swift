//
//  Model.swift
//  AFSample
//
//  Created by Amreth on 12/10/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import Foundation

import ObjectMapper

class Article: Mappable{
    var id: Int?
    var title: String?
    var description: String?
    var createdDate: String?
    var status: String?
    var image: String?
    var author: Author?
    var category: Category?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["ID"]
        title       <- map["TITLE"]
        description <- map["DESCRIPTION"]
        createdDate <- map["CREATED_DATE"]
        status      <- map["STATUS"]
        image       <- map["IMAGE"]
        author      <- map["AUTHOR"]
        category    <- map["CATEGORY"]
        
    }
}

class Category: Mappable{
    var id:Int?
    var name:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id    <- map["ID"]
        name  <- map["NAME"]
    }
}

class Author: Mappable{
    var id:Int?
    var name:String?
    var email:String?
    var gender:String?
    var telephone:String?
    var status:String?
    var facebook_id:String?
    var image_url:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["ID"]
        name        <- map["NAME"]
        email       <- map["EMAIL"]
        gender      <- map["GENDER"]
        telephone   <- map["TELEPHONE"]
        status      <- map["STATUS"]
        facebook_id <- map["FACEBOOK_ID"]
        image_url   <- map["IMAGE_URL"]
    }
    
}
