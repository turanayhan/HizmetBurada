import FirebaseDatabase
import Foundation

class ChatManager {

    private let db = Database.database().reference()

    // Sohbet oluşturma
    func createChat(participants: [String], completion: @escaping (String?) -> Void) {
        let chatID = UUID().uuidString
        let chat = ChatModel(chatID: chatID, participants: participants, timestamp: Date(), lastMessage: nil)

        db.child("chats").child(chatID).setValue([
            "participants": participants,
            "timestamp": chat.timestamp.timeIntervalSince1970
        ]) { error, _ in
            if let error = error {
                print("Sohbet oluşturulamadı: \(error)")
                completion(nil)
            } else {
                self.saveChatID(chatID, for: participants)
                print("Sohbet oluşturuldu: \(chatID)")
                completion(chatID)
            }
        }
    }
    
    // Kullanıcı bilgilerini çekme
    func fetchUsers(userIDs: [String], completion: @escaping ([User]) -> Void) {
        var users: [User] = []
        let dispatchGroup = DispatchGroup()

        for userID in userIDs {
            dispatchGroup.enter()
            db.child("User").child(userID).observeSingleEvent(of: .value) { snapshot in
                guard let data = snapshot.value as? [String: Any] else {
                    dispatchGroup.leave()
                    return
                }

                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let user = try JSONDecoder().decode(User.self, from: jsonData)
                    users.append(user)
                } catch {
                    print("Kullanıcı verisi dönüştürülürken hata oluştu: \(error)")
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(users)
        }
    }

    // Chat ID kaydetme
    private func saveChatID(_ chatID: String, for participants: [String]) {
        for participant in participants {
            db.child("statusChat").child(participant).child("chats").child(chatID).setValue(true)
        }
    }

    // Mesaj gönderme
    func sendMessage(chatID: String, senderID: String, recipientID: String, text: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let messageID = db.child("chats").child(chatID).child("messages").childByAutoId().key ?? UUID().uuidString
        let timestamp = Date().timeIntervalSince1970

        let messageData: [String: Any] = [
            "messageID": messageID,
            "senderID": senderID,
            "recipientID": recipientID,
            "text": text,
            "timestamp": timestamp
        ]

        // Mesajı ekliyoruz
        db.child("chats").child(chatID).child("messages").child(messageID).setValue(messageData) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                // Son mesajı güncellemek için ek veri oluşturuyoruz
                let lastMessageData: [String: Any] = [
                    "text": text,
                    "timestamp": timestamp,
                    "senderID": senderID
                ]

                // `lastMessage` alanını güncelliyoruz
                self.db.child("chats").child(chatID).child("lastMessage").setValue(lastMessageData) { error, _ in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }


    // Kullanıcıya ait sohbetleri çekme
    func fetchUserChats(userID: String, completion: @escaping ([String]) -> Void) {
        db.child("statusChat").child(userID).child("chats").observeSingleEvent(of: .value) { snapshot in
            guard let chatIDs = snapshot.value as? [String: Bool] else {
                print("Sohbetler alınamadı.")
                completion([])
                return
            }
            let chats = Array(chatIDs.keys)
            completion(chats)
        } withCancel: { error in
            print("Veri alma hatası: \(error.localizedDescription)")
            completion([])
        }
    }

    // Sohbete ait mesajları gözlemleme
    func observeMessages(chatID: String, completion: @escaping ([MessageModel]) -> Void) {
        var messages: [MessageModel] = []
        
        db.child("chats").child(chatID).child("messages").observe(.childAdded) { snapshot in
            guard let data = snapshot.value as? [String: Any] else { return }
            
            let message = MessageModel(
                messageID: snapshot.key,
                senderID: data["senderID"] as? String ?? "",
                recipientID: data["recipientID"] as? String ?? "",
                text: data["text"] as? String ?? "",
                timestamp: Date(timeIntervalSince1970: data["timestamp"] as? TimeInterval ?? 0)
            )
            
            messages.append(message)
            completion(messages)
        } withCancel: { error in
            print("Mesajları alma hatası: \(error.localizedDescription)")
        }
    }

    func observeChat(chatID: String, completion: @escaping (ChatModel?) -> Void) {
        db.child("chats").child(chatID).observe(.value) { snapshot in
            guard let data = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }

            // ChatModel ana bilgilerini oluşturuyoruz
            let chatID = chatID
            let participants = data["participants"] as? [String] ?? []
            let timestamp = Date(timeIntervalSince1970: data["timestamp"] as? TimeInterval ?? 0)

            // LastMessage bilgilerini alıyoruz
            var lastMessage: LastMessage? = nil
            if let lastMessageData = data["lastMessage"] as? [String: Any] {
                let messageText = lastMessageData["text"] as? String ?? ""
                let messageTimestamp = Date(timeIntervalSince1970: lastMessageData["timestamp"] as? TimeInterval ?? 0)
                let senderID = lastMessageData["senderID"] as? String ?? ""
                lastMessage = LastMessage(text: messageText, timestamp: messageTimestamp, senderID: senderID)
            }

            // ChatModel'u oluşturup completion ile döndürüyoruz
            let chat = ChatModel(
                chatID: chatID,
                participants: participants,
                timestamp: timestamp,
                lastMessage: lastMessage
            )
            
            completion(chat)
            
        } withCancel: { error in
            print("Sohbet bilgilerini alma hatası: \(error.localizedDescription)")
            completion(nil)
        }
    }

    
    
    
    
    
    
}
