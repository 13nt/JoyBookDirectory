//
//  APIHeaders.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import Foundation
import Alamofire

class APIHeaders {
    
    static let shared = APIHeaders()
    
    func getHeader(isMultipart: Bool = false) -> HTTPHeaders {
        
        var headers: HTTPHeaders = [
            .accept("application/json")
        ]
        
        if isMultipart {
            headers.add(name: "Content-Type", value: "multipart/form-data")
        }
        
        debugPrint("Headers: \(headers.dictionary)")
        return headers
    }
}

