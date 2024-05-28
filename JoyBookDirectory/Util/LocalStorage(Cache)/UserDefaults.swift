//
//  UserDefaults.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 29/05/2024.
//

import Foundation

struct UserDefaultKey {
    static let Username = "Username"
    static let IsLogin = "IsLogin"
}

class LocalStorage {
    static let shared = LocalStorage()
    let defaults = UserDefaults.standard
    
    func setUsername(_ userName : String){
        defaults.setValue(userName, forKey: UserDefaultKey.Username)
    }
    
    func getUsername() -> String?{
        return defaults.object(forKey: UserDefaultKey.Username) as? String ?? ""
    }
    
    func setIsLoggedIn(_ isLoggedIn: Bool) {
        defaults.setValue(isLoggedIn, forKey: UserDefaultKey.IsLogin)
    }
    
    func isLoggedIn() -> Bool {
        return defaults.bool(forKey: UserDefaultKey.IsLogin)
    }
    
    func logout() {
        defaults.removeObject(forKey: UserDefaultKey.Username)
        defaults.removeObject(forKey: UserDefaultKey.IsLogin)
    }
}
