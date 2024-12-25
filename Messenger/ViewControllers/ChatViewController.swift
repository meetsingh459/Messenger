//
//  ChatViewController.swift
//  Messenger
//
//  Created by Manmeet Singh on 25/12/24.
//

import UIKit
import MessageKit

struct Messages: MessageType {
    var sender: any MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

class ChatViewController: MessagesViewController {
    
    private let selfSender = Sender(senderId: "1", displayName: "Manmeet")
    private let otherSender = Sender(senderId: "2", displayName: "King")
    
    private var messages = [Messages]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messages.append(Messages(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hi I'm Manmeet")))
        messages.append(Messages(sender: otherSender, messageId: "2", sentDate: Date(), kind: .text("Hi I'm King")))
        messages.append(Messages(sender: selfSender, messageId: "3", sentDate: Date(), kind: .text("How are you king")))
        messages.append(Messages(sender: otherSender, messageId: "4", sentDate: Date(), kind: .text("I'm good how are you Manmeet, How's you day going")))
        messages.append(Messages(sender: selfSender, messageId: "5", sentDate: Date(), kind: .text("It's none of your buisness King!!!")))
        
        messagesCollectionView.reloadData()
    }
}

extension ChatViewController: MessagesDisplayDelegate, MessagesDataSource, MessagesLayoutDelegate {
    var currentSender: any MessageKit.SenderType {
        print("currentSender")
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> any MessageKit.MessageType {
        print("messageForItem")
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        print("Messages.connt \(messages.count)")
        return messages.count
    }
}
