//
//  UserDefaults.swift
//  Talk_Me
//
//  Created by Abdusamad Mamasoliyev on 29/12/23.
//

import Foundation

extension UserDefaults {
    
    func isUserDefaults()-> Bool {
        return bool(forKey: "user_login")
    }
    func setUserAuth() {
        set(true, forKey: "user_login")
    }
}
