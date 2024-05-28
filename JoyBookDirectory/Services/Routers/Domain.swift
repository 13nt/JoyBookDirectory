//
//  Domain.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import Foundation

struct Domain {
    static let url = "https://www.dbooks.org/api/"
}

extension Domain {
    static func baseUrl() -> String {
        return Domain.url
    }
}
