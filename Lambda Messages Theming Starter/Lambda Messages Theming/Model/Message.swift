//
//  Message.swift
//  UIAppearanceAndAnimation
//
//  Created by Spencer Curtis on 8/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Message: Codable, Hashable {
    
    let text: String
    let sender: String
    let identifier: UUID
    let timestamp: Date
    
    init(text: String, sender: String, identifier: UUID = UUID(), timestamp: Date = Date()) {
        self.text = text
        self.sender = sender
        self.identifier = identifier
        self.timestamp = timestamp
    }
    
}
