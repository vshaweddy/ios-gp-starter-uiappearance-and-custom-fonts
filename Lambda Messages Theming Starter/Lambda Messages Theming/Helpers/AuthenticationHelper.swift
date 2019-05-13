//
//  AuthenticationHelper.swift
//  UIAppearanceAndAnimation
//
//  Created by Spencer Curtis on 8/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

enum AuthenticationHelper {
    
    static func setCurrentUser(to username: String) {
        UserDefaults.standard.set(username, forKey: currentUserKey)
    }
    
    static var currentUser: String? {
        return UserDefaults.standard.string(forKey: currentUserKey)
    }
    
    static private let currentUserKey = "CurrentUser"
}
