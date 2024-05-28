//
//  PublicFunctions.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 29/05/2024.
//

import Foundation

func isValidUsername(_ username: String) -> Bool {
    let usernameRegex = "^[a-zA-Z0-9_]+$"
    let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
    return usernameTest.evaluate(with: username)
}
