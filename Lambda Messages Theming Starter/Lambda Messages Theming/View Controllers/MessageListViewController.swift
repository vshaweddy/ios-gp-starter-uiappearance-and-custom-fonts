//
//  MessageListViewController.swift
//  UIAppearanceAndAnimation
//
//  Created by Spencer Curtis on 8/20/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(sortMessageArray), name: messagesWereUpdatedNotification, object: nil)
        
        messageController.fetchMessages()
    }
    
    @objc private func sortMessageArray() {
        switch messageSortSegmentedControl.selectedSegmentIndex {
        case 0:
            messageController.messages.sort(by: { $0.timestamp < $1.timestamp })
        case 1:
            messageController.messages.sort(by: { $0.timestamp > $1.timestamp })
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    @IBAction func sortMessages(_ sender: Any) {
        sortMessageArray()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageController.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        
        let message = messageController.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.sender
        
        return cell
    }

    let messageController = MessageController()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.timeStyle = .long
        formatter.dateStyle = .short
        
        return formatter
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateMessage" {
            guard let destinationVC = segue.destination as? MessageCreationViewController else { return }
            
            destinationVC.messageController = messageController
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newMessageButton: UIButton!
    @IBOutlet weak var messageSortSegmentedControl: UISegmentedControl!
}
