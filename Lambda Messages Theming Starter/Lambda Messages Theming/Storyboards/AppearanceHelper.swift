//
//  AppearanceHelper.swift
//  Lambda Messages Theming
//
//  Created by Vici Shaweddy on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
    static var lambdaRed = UIColor(red: 212.0/255.0, green: 87.0/255.0, blue: 80.0/255.0, alpha: 1.0)
    static var backgroundGray = UIColor(red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1.0)
    
    static func typerighterFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let font = UIFont(name: "RM Typerighter medium", size: pointSize)! // force unwrap because we're lazy, we should probably return an optional UIFont
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font) // scale is good for automatically scaling the size of the font when there are various devices
    }
    
    static func setDarkAppearance() {
        UINavigationBar.appearance().barTintColor = backgroundGray
        // appearance help change the appearance proxy
        UISegmentedControl.appearance().tintColor = lambdaRed
        UIBarButtonItem.appearance().tintColor = lambdaRed
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        UITextField.appearance().tintColor = lambdaRed
        UITextView.appearance().tintColor = lambdaRed
    }
    
    static func style(button: UIButton) {
        button.titleLabel?.font = typerighterFont(with: .callout, pointSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = lambdaRed
        button.layer.cornerRadius = 8
        
    }
    
}
