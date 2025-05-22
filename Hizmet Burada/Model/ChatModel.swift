//
//  ChatFile.swift
//  Hizmet Burada
//
//  Created by turan on 24.10.2024.
//

import Foundation

struct ChatModel {
    let chatID: String
    let participants: [String]
    let timestamp: Date
    let lastMessage: LastMessage?
}

struct LastMessage {
    let text: String
    let timestamp: Date
    let senderID: String
}


struct ChatWithUsersModel {
    let chat: ChatModel
    let participantsInfo: [User]
}
