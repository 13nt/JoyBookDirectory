//
//  BookListResponse.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import Foundation
import ObjectMapper

struct BookListResponse: Mappable{
    var status: String?
    var total: String?
    var bookListData: [BookListData]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        total <- map["total"]
        bookListData <- map["books"]
    }
}

struct BookListData: Mappable{
    var id : String?
    var title : String?
    var subtitle : String?
    var authors : String?
    var image : String?
    var url : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        authors <- map["authors"]
        image <- map["image"]
        url <- map["url"]
    }
}
