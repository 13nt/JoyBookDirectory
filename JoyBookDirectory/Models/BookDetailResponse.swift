//
//  BookDetailResponse.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import Foundation
import ObjectMapper

struct BookDetailResponse: Mappable{
    var status: String?
    var id : String?
    var title : String?
    var subtitle : String?
    var description: String?
    var authors : String?
    var publisher : String?
    var pages : String?
    var year : String?
    var image : String?
    var url : String?
    var download : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        id <- map["id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        description <- map["description"]
        authors <- map["authors"]
        publisher <- map["publisher"]
        pages <- map["pages"]
        year <- map["year"]
        image <- map["image"]
        url <- map["url"]
        download <- map["download"]
    }
}
