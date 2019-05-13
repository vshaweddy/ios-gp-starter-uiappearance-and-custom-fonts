//
//  MessageController.swift
//  UIAppearanceAndAnimation
//
//  Created by Spencer Curtis on 8/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

let messagesWereUpdatedNotification = Notification.Name("MessagesWereUpdated")


class MessageController {
    
    func createMessage(with text: String, completion: @escaping ((Error?) -> Void) = { _ in}) {
        
        guard let sender = AuthenticationHelper.currentUser else { fatalError("No current user") }
        
        let message = Message(text: text, sender: sender)
        
        messages.insert(message, at: 0)
        
        put(message: message, completion: completion)
    }
    
    func fetchMessages(completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching messages from server: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                let messages = try JSONDecoder().decode([String: Message].self, from: data).map({ $0.value }).sorted(by: {$0.timestamp > $1.timestamp })
                self.messages = messages
            } catch {
                NSLog("Error decoding messages: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    
    private func put(message: Message, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let requestURL = baseURL.appendingPathComponent(message.identifier.uuidString).appendingPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "PUT"
        
        do {
            request.httpBody = try JSONEncoder().encode(message)
        } catch {
            NSLog("Error encoding message: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error PUTting message to server: \(error)")
                completion(error)
                return
            }

            completion(nil)
            
        }.resume()
        
    }
    
    private let baseURL = URL(string: "https://lambda-message-board.firebaseio.com/messages")!
    
    var messages: [Message] = [] {
        didSet {
            guard messages != oldValue else { return }
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil, userInfo: nil)
            }
        }
    }
}
